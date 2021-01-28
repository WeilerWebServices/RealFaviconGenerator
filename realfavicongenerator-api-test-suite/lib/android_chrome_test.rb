require 'rfg_api_test'

class AndroidChromeTest < RFGAPITest
  def test_basic
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          android_chrome: {
            manifest: {}
          }
        }
      }
    }, expected_dir_path, <<EOT
<link rel="icon" type="image/png" sizes="192x192" href="/android-chrome-192x192.png">
<link rel="manifest" href="/site.webmanifest">
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
          path: "/path/to/icons"
        },
        favicon_design: {
          android_chrome: {
            master_picture: {
              type: :inline,
              content: "#{to_base64('resources/master_1_120x120.png')}"
            },
            manifest: {
              name: 'Sample app',
              start_url: 'http://example.com/android'
            }
          }
        }
      }
    }, expected_dir_path, <<EOT
<link rel="manifest" href="/path/to/icons/site.webmanifest">
EOT
    )
  end

  def test_background_and_margin
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          android_chrome: {
            picture_aspect: :background_and_margin,
            background_color: '#abcdef',
            margin: '10%',
            manifest: {
              name: 'An app',
              orientation: :portrait,
              display: :standalone,
              start_url: 'http://example.com/android'
            },
            theme_color: '#469716'
          }
        }
      }
    }, expected_dir_path, <<EOT
<link rel="icon" type="image/png" sizes="194x194" href="/favicon-194x194.png">
<link rel="icon" type="image/png" sizes="192x192" href="/android-chrome-192x192.png">
<link rel="manifest" href="/site.webmanifest">
<meta name="theme-color" content="#469716">
EOT
    )
  end

  def test_shadow
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          android_chrome: {
            picture_aspect: :shadow,
            manifest: {},
            theme_color: '#fedcba'
          }
        }
      }
    }, expected_dir_path, <<EOT
<link rel="icon" type="image/png" sizes="194x194" href="/favicon-194x194.png">
<link rel="icon" type="image/png" sizes="192x192" href="/android-chrome-192x192.png">
<link rel="manifest" href="/site.webmanifest">
<meta name="theme-color" content="#fedcba">
EOT
    )
  end

  def test_no_change
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          android_chrome: {
            picture_aspect: :no_change,
            manifest: {}
          }
        }
      }
    }, expected_dir_path, <<EOT
<link rel="icon" type="image/png" sizes="192x192" href="/android-chrome-192x192.png">
<link rel="manifest" href="/site.webmanifest">
EOT
    )
  end

  def test_existing_manifest
    existing_manifest = {
      name: "Some app"
    }

    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          android_chrome: {
            picture_aspect: :no_change,
            manifest: {
              existing_manifest: existing_manifest.to_json
            }
          }
        }
      }
    }, expected_dir_path, <<EOT
<link rel="icon" type="image/png" sizes="192x192" href="/android-chrome-192x192.png">
<link rel="manifest" href="/site.webmanifest">
EOT
    )
  end

  def test_no_low_resolution
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          android_chrome: {
            manifest: {},
            assets: {
              low_resolution_icons: false
            }
          }
        }
      }
    }, expected_dir_path, <<EOT
<link rel="icon" type="image/png" sizes="192x192" href="/android-chrome-192x192.png">
<link rel="manifest" href="/site.webmanifest">
EOT
    )
  end

  def test_no_legacy_icon
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          android_chrome: {
            manifest: {},
            theme_color: '#fedcba',
            assets: {
              legacy_icon: false
            }
          }
        }
      }
    }, expected_dir_path, <<EOT
<link rel="manifest" href="/site.webmanifest">
<meta name="theme-color" content="#fedcba">
EOT
    )
  end
end
