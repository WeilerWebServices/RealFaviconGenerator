require 'rfg_api_test'

class VersioningTest < RFGAPITest
  def test_no_version
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          desktop_browser: {}
        }
      }
    }, expected_dir_path, <<EOT
<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
EOT
    )
  end

  def test_no_version_explicit
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          desktop_browser: {}
        },
        versioning: false
      }
    }, expected_dir_path, <<EOT
<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
EOT
    )
  end

  def test_version_with_value
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          desktop_browser: {}
        },
        versioning: {
          param_value: '789XYZ'
        }
      }
    }, expected_dir_path, <<EOT
<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png?v=789XYZ">
<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png?v=789XYZ">
<link rel="shortcut icon" href="/favicon.ico?v=789XYZ">
EOT
    )
  end

  def test_version_with_value_and_name
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          desktop_browser: {}
        },
        versioning: {
          param_name: 'stuff',
          param_value: '789XYZ'
        }
      }
    }, expected_dir_path, <<EOT
<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png?stuff=789XYZ">
<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png?stuff=789XYZ">
<link rel="shortcut icon" href="/favicon.ico?stuff=789XYZ">
EOT
    )
  end

  def test_version_defaults
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          desktop_browser: {}
        },
        versioning: true
      }
    }, expected_dir_path, /\?v=\w+/, true)
  end
end
