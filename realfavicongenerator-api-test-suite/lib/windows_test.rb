require 'rfg_api_test'

class WindowsTest < RFGAPITest
  def test_basic
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          windows: {}
        }
      }
    }, expected_dir_path, <<EOT
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage" content="/mstile-144x144.png">
EOT
    )
  end

  def test_selection
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          windows: {
            assets: {
              windows_80_ie_10_tile: false,
              windows_10_ie_11_edge_tiles: {
                small: false
              }
            }
          }
        }
      }
    }, expected_dir_path, <<EOT
<meta name="msapplication-TileColor" content="#ffffff">
EOT
    )
  end

  def test_basic_not_in_root
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        files_location: {
          type: :path,
          path: '/path/to/icons'
        },
        favicon_design: {
          windows: {
             background_color: '#bafe46'
          }
        }
      }
    }, expected_dir_path, <<EOT
<meta name="msapplication-TileColor" content="#bafe46">
<meta name="msapplication-TileImage" content="/path/to/icons/mstile-144x144.png">
<meta name="msapplication-config" content="/path/to/icons/browserconfig.xml">
EOT
    )
  end

  def test_white_silhouette
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          windows: {
            picture_aspect: :white_silhouette,
            background_color: '#95ae4b',
            master_picture: {
              type: :inline,
              content: "#{to_base64('resources/master_1_120x120.png')}"
            }
          }
        }
      }
    }, expected_dir_path, <<EOT
<meta name="msapplication-TileColor" content="#95ae4b">
EOT
    )
  end

  def test_white_silhouette_not_in_root
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        files_location: {
          type: :path,
          path: '/path/to/icons'
        },
        favicon_design: {
          windows: {
            picture_aspect: :white_silhouette,
            background_color: '#ca1287',
          }
        }
      }
    }, expected_dir_path, <<EOT
<meta name="msapplication-TileColor" content="#ca1287">
<meta name="msapplication-TileImage" content="/path/to/icons/mstile-144x144.png">
<meta name="msapplication-config" content="/path/to/icons/browserconfig.xml">
EOT
    )
  end

  def test_app_name
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          windows: {
            app_name: 'My great app'
          }
        }
      }
    }, expected_dir_path, <<EOT
<meta name="application-name" content="My great app">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage" content="/mstile-144x144.png">
EOT
    )
  end
end
