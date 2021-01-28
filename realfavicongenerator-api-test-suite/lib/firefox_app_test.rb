require 'rfg_api_test'

class FirefoxAppTest < RFGAPITest
  def test_basic
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          firefox_app: {}
        }
      }
    }, expected_dir_path, "\n")
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
          firefox_app: {
            manifest: {
              app_name: 'Hello app',
              app_description: 'A sample desription'
            }
          }
        }
      }
    }, expected_dir_path, "\n")
  end

  def test_circle_custom_1
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          firefox_app: {
            picture_aspect: :circle,
            margin: '35%',
            keep_picture_in_circle: false,
            circle_overlay: false,
            background_color: '#9a4cf0',
            master_picture: {
              type: :inline,
              content: "#{to_base64('resources/master_2_128x128.png')}"
            },
            manifest: {
              app_name: 'Another app',
              app_description: 'Oh my!',
              developer_name: 'Walter White',
              developer_url: 'http://example.com/walter'
            }
          }
        }
      }
    }, expected_dir_path, "\n")
  end
  
  def test_circle_custom_2
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          firefox_app: {
            picture_aspect: :circle,
            circle_inner_margin: '15%',
            keep_picture_in_circle: true,
            circle_overlay: true,
            background_color: '#ff4500',
            master_picture: {
              type: :inline,
              content: "#{to_base64('resources/master_2_128x128.png')}"
            },
            manifest: {
              developer_name: 'Walter White',
              developer_url: 'http://example.com/walter'
            }
          }
        }
      }
    }, expected_dir_path, "\n")
  end
  
  def test_rounded_square
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          firefox_app: {
            picture_aspect: :rounded_square,
            background_color: '#6699bb',
            margin: '50%'
          }
        }
      }
    }, expected_dir_path, "\n")
  end
  
  def test_square
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          firefox_app: {
            picture_aspect: :square,
            background_color: '#ff7822',
            margin: '20%'
          }
        }
      }
    }, expected_dir_path, "\n")
  end
  
  def test_existing_manifest
    existing_manifest = {
      default_locale: :en
    }
    
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          firefox_app: {
            picture_aspect: :square,
            background_color: '#ff7822',
            margin: '20%',
            manifest: {
              existing_manifest: existing_manifest.to_json
            }
          }
        }
      }
    }, expected_dir_path, "\n")
  end
  
  # See https://github.com/RealFaviconGenerator/realfavicongenerator/issues/126
  def test_issue126
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :inline,
          content: "#{to_base64('resources/master_picture_issue126.png')}"
        },
        favicon_design: {
          firefox_app: {
            picture_aspect: :circle,
            circle_inner_margin: 5,
            keep_picture_in_circle: true,
            circle_overlay: true,
            background_color: '#9a4cf0'
          }
        }
      }
    }, expected_dir_path, "\n")
  end
end
