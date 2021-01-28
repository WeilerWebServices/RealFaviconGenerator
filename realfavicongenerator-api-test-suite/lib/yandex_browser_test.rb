require 'rfg_api_test'

class YandexBrowserTest < RFGAPITest
  def test_basic
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          yandex_browser: {}
        }
      }
    }, expected_dir_path, <<EOT
<link rel="yandex-tableau-widget" href="/yandex-browser-manifest.json">
EOT
    )
  end
  
  def test_background
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        files_location: {
          type: :path,
          path: "/path/to/icons"
        },
        favicon_design: {
          yandex_browser: {
            background_color: '#97ad48',
            manifest: {
              show_title: false,
              version: '1.2.3'
            }
          }
        }
      }
    }, expected_dir_path, <<EOT
<link rel="yandex-tableau-widget" href="/path/to/icons/yandex-browser-manifest.json">
EOT
    )
  end
  
  def test_existing_manifest
    existing_manifest = {
      feed: {
        some: :stuff
      }
    }
    
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          yandex_browser: {
            manifest: {
              existing_manifest: existing_manifest.to_json
            }
          }
        }
      }
    }, expected_dir_path, <<EOT
<link rel="yandex-tableau-widget" href="/yandex-browser-manifest.json">
EOT
    )
  end
end
