require 'rfg_api_test'

class UsePathAsIsTest < RFGAPITest
  def setup
    @default_request = {
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        files_location: {
          type: :path,
          path: 'sub/dir'
        },
        favicon_design: {
          windows: {},
          android_chrome: {
            manifest: {}
          },
          yandex_browser: {
            manifest: {}
          }
        }
      }
    }
  end

  def test_do_use_path_as_is_by_default
    favicon_generation(@default_request, expected_dir_path, <<EOT
<link rel="icon" type="image/png" sizes="192x192" href="sub/dir/android-chrome-192x192.png">
<link rel="manifest" href="sub/dir/site.webmanifest">
<link rel="yandex-tableau-widget" href="sub/dir/yandex-browser-manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage" content="sub/dir/mstile-144x144.png">
<meta name="msapplication-config" content="sub/dir/browserconfig.xml">
EOT
    )
  end

  def test_do_use_path_as_is
    @default_request[:favicon_generation][:settings] = {
      use_path_as_is: true
    }
    favicon_generation(@default_request, expected_dir_path, <<EOT
<link rel="icon" type="image/png" sizes="192x192" href="sub/dir/android-chrome-192x192.png">
<link rel="manifest" href="sub/dir/site.webmanifest">
<link rel="yandex-tableau-widget" href="sub/dir/yandex-browser-manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage" content="sub/dir/mstile-144x144.png">
<meta name="msapplication-config" content="sub/dir/browserconfig.xml">
EOT
    )
  end

  def test_do_not_use_path_as_is
    @default_request[:favicon_generation][:settings] = {
      use_path_as_is: false
    }
    favicon_generation(@default_request, expected_dir_path, <<EOT
<link rel="icon" type="image/png" sizes="192x192" href="sub/dir/android-chrome-192x192.png">
<link rel="manifest" href="sub/dir/site.webmanifest">
<link rel="yandex-tableau-widget" href="sub/dir/yandex-browser-manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage" content="sub/dir/mstile-144x144.png">
<meta name="msapplication-config" content="sub/dir/browserconfig.xml">
EOT
    )
  end
end
