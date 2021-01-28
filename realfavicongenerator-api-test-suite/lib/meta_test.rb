require 'rfg_api_test'

# Some tests to test the test suite. Wow.

class MetaTest < RFGAPITest
  def test_files_list
    assert_equal ['root.txt', 'sub_1/deep_1.txt', 'sub_1/sub_2/deep_2.txt'], 
      files_list(File.dirname(File.expand_path(__FILE__)) + '/../expected_files/meta_test/test_files_list')
  end
  
  def test_expected_dir_path
    assert_equal 'expected_files/meta_test/test_expected_dir_path', expected_dir_path
  end
  
  def test_assert_file_equal
    path = expected_dir_path
    
    # Test file
    assert_file_equal "#{path}/original_file.txt", "#{path}/identical_to_original.txt"
    assert_raises MiniTest::Assertion do
      assert_file_equal "#{path}/original_file.txt", "#{path}/different_file.txt"
    end
    
    # PNG picture
    assert_file_equal "#{path}/original_picture.png", "#{path}/identical_to_original.png"
    # Some little changes in this one, but rather in meta data
    assert_file_equal "#{path}/original_picture.png", "#{path}/similar_to_original.png"
    ['not_same_size.png', 'not_same_format.jpg', 'no_same_content.png'].each do |pic|
      assert_raises MiniTest::Assertion do
        assert_file_equal "#{path}/original_picture.png", "#{path}/#{pic}"
      end
    end
    
    # ICO picture
    assert_file_equal "#{path}/original_ico.ico", "#{path}/identical_to_original.ico"
    ['not_same_amount_of_pictures.ico', 'not_same_content.ico'].each do |pic|
      assert_raises MiniTest::Assertion do
        assert_file_equal "#{path}/original_ico.ico", "#{path}/#{pic}"
      end
    end
  end
  
  def test_assert_directory_equal
    path = expected_dir_path
    
    assert_directory_equal "#{path}/original", "#{path}/identical"
    ['not_same_files', 'not_same_content'].each do |dir|
      assert_raises MiniTest::Assertion do
        assert_directory_equal "#{path}/original", "#{path}/#{dir}"
      end
    end
  end
  
  def test_get_pixel_depth
    assert_equal 8,  get_pixel_depth(expected_dir_path + '/depth_8.png')
    assert_equal 16, get_pixel_depth(expected_dir_path + '/depth_16.png')
  end
end
