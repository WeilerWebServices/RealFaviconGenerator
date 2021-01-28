require 'minitest/autorun'
require 'rest_client'
require 'json'
require 'open-uri'
require 'zip'
require 'rmagick'
require 'base64'

class RFGAPITest < Minitest::Test
  include Magick

  def setup
    FileUtils.rm_rf 'observed_files'
  end

  def favicon_generation(request, expected_file_dir, expected_html, is_regexpr = false, expected_replaced_markups = nil)
    return any_generation('favicon', request, expected_file_dir, expected_html, is_regexpr, expected_replaced_markups)
  end

  def social_generation(request, expected_file_dir, expected_html, is_regexpr = false, expected_replaced_markups = nil)
    return any_generation('social', request, expected_file_dir, expected_html, is_regexpr, expected_replaced_markups)
  end

  def any_generation(path, request, expected_file_dir, expected_html, is_regexpr = false, expected_replaced_markups = nil)
    response = RestClient::Request.execute(
      method: :post,
      url: "https://realfavicongenerator.net/api/#{path}",
      payload: request.to_json,
      content_type: :json,
      timeout: 240)

    response = JSON.parse response.body

    assert_equal 'success', response['favicon_generation_result']['result']['status']
    if is_regexpr
      assert_match expected_html, response['favicon_generation_result']['favicon']['html_code'] + "\n"
    else
      assert_equal expected_html, response['favicon_generation_result']['favicon']['html_code'] + "\n"
    end

    dir = observed_dir_path(2)
    # Download the package
    FileUtils.mkdir_p "#{dir}/package"
    download_package response['favicon_generation_result']['favicon']['package_url'], "#{dir}/package"
    # Also download each files
    FileUtils.mkdir_p "#{dir}/individual_files"
    response['favicon_generation_result']['favicon']['files_urls'].each do |file|
      download_file file, "#{dir}/individual_files"
    end

    assert_directory_equal expected_file_dir, "#{dir}/package", "Comparison of #{dir}/package and #{expected_file_dir}"
    assert_directory_equal "#{dir}/individual_files", "#{dir}/package", "Comparison of #{dir}/individual_files and #{dir}/package"

    if expected_replaced_markups
      assert_equal expected_replaced_markups,
        response['favicon_generation_result']['favicon']['overlapping_markups']
    end
  end

  def favicon_generation_with_error(request)
    begin
      response = RestClient.post("http://realfavicongenerator.net/api/favicon", request.to_json, content_type: :json)
      flunk 'Exception expected'
    rescue => e
      assert_equal 400, e.response.code
    end
  end

  def assert_directory_equal(expected_dir, observed_dir, msg = nil)
    observed_files = files_list(observed_dir).sort
    assert_equal files_list(expected_dir).sort, observed_files, msg
    observed_files.each do |file|
      assert_file_equal "#{expected_dir}/#{file}", "#{observed_dir}/#{file}"
    end
  end

  def assert_file_equal(expected_file, observed_file)
    case File.extname(observed_file)
    when '.ico'
      Dir.mktmpdir 'rfg_test_suite_ico_exp'  do |out_exp|
        Dir.mktmpdir 'rfg_test_suite_ico_OBS'  do |out_obs|
          extract_ico(expected_file, out_exp)
          extract_ico(observed_file, out_obs)
          assert_directory_equal(out_exp, out_obs)
        end
      end
      assert_file_size(expected_file, observed_file)
    when '.png', '.jpg'
      obs = ImageList.new(observed_file)
      exp = ImageList.new(expected_file)

      assert_equal exp.format, obs.format
      assert_equal [exp.columns, exp.rows], [obs.columns, obs.rows], "Dimensions of #{expected_file} vs #{observed_file}"
      if (exp.columns < 500) and (exp.rows < 500)
        # Large pictures cause the test to crash...

        # See https://github.com/RealFaviconGenerator/realfavicongenerator/issues/157
        assert_equal 8, get_pixel_depth(observed_file), "Pixel depth of #{observed_file}"

        assert_equal get_image_pixel(exp), get_image_pixel(obs), "Content of #{observed_file}"
      end
      assert_file_size(expected_file, observed_file)
    else
      assert_equal File.read(expected_file), File.read(observed_file)
    end
  end

  def assert_file_size(expected_file, observed_file, threshold = 0.25)
    es = File.size(expected_file)
    os = File.size(observed_file)
    low = es * (1 - threshold)
    high = es * (1 + threshold)
    assert ((low < os) and (os < high)),
      "#{observed_file} is #{os} bytes large. Its size should be between #{low} and #{high}"
  end

  def extract_ico(ico_file, output_dir)
    system("icotool -x -o #{output_dir} #{ico_file} 2>/dev/null")

    Dir.foreach(output_dir) do |item|
      next if item == '.' or item == '..'
      if item =~ /.*(\d+x\d+)x\d+\.png/
        File.rename("#{output_dir}/#{item}", "#{output_dir}/#{$1}.png")
      end
    end
  end

  def get_image_pixel(image)
    image.get_pixels(0, 0, image.columns, image.rows).map {|p| p.to_color}
  end

  def files_list(directory, base_dir = nil)
    list = []
    Dir.foreach(directory) do |item|
      next if item == '.' or item == '..'
      if File.directory? "#{directory}/#{item}"
        list += files_list("#{directory}/#{item}", ((base_dir == nil) ? item : "#{base_dir}/#{item}"))
      else
        list << ((base_dir == nil) ? item : "#{base_dir}/#{item}")
      end
    end
    list
  end

  def download_package(package_url, output_dir)
    file = Tempfile.new('fav_package')
    file.close
    download_file package_url, file.path
    extract_zip file.path(), output_dir
  end

  def download_file(url, local_path)
    if File.directory?(local_path)
      uri = URI.parse(url)
      local_path += '/' + File.basename(uri.path)
    end

    File.open(local_path, "wb") do |saved_file|
      open(url, "rb") do |read_file|
        saved_file.write(read_file.read)
      end
    end
  end

  def extract_zip(zip_path, output_dir)
    Zip::ZipFile.open zip_path do |zip_file|
      zip_file.each do |f|
        f_path=File.join  output_dir, f.name
        FileUtils.mkdir_p  File.dirname(f_path)
        File.unlink f_path if File.exist? f_path
        zip_file.extract(f, f_path)
      end
    end
  end

  def observed_dir_path(level = 0)
    # eg. "test_some_stuff"
    method = (caller[level] =~ /`([^']*)'/ and $1)
    # eg. "some_test"
    file = (caller[level] =~ /([^\/:]*).rb:/ and $1)
    # eg. observed_files/some_test/test_some_stuff
    dir = 'observed_files/' + file + '/' + method
  end

  def expected_dir_path
    # eg. "test_some_stuff"
    method = (caller[0] =~ /`([^']*)'/ and $1)
    # eg. "some_test"
    file = (caller[0] =~ /([^\/:]*).rb:/ and $1)
    # eg. expected_files/some_test/test_some_stuff
    dir = 'expected_files/' + file + '/' + method
  end

  def to_base64(file)
    Base64.strict_encode64 File.read(file)
  end

  def get_pixel_depth(image)
    out = `identify #{image}`
    return (out =~ /\s+(\d+)-bit\s+/) ? $1.to_i : nil
   end
end
