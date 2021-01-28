require 'rfg_api_test'

class GlobalTest < RFGAPITest
  def test_1
    expected_html = <<EOT
<link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="/apple-touch-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="/apple-touch-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="/apple-touch-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="/apple-touch-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon-180x180.png">
<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="230x230" href="/favicon-230x230.png">
<link rel="icon" type="image/png" sizes="192x192" href="/android-chrome-192x192.png">
<link rel="icon" type="image/png" sizes="228x228" href="/coast-228x228.png">
<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
<link rel="manifest" href="/site.webmanifest">
<link rel="yandex-tableau-widget" href="/yandex-browser-manifest.json">
<meta property="og:image" content="/open-graph.png">
<meta name="msapplication-TileColor" content="#789abc">
<meta name="msapplication-TileImage" content="/mstile-144x144.png">
<meta name="theme-color" content="#99abcd">
EOT

    expected_replaced_markups = [
      'link[rel="apple-touch-icon"]',
      'link[rel="shortcut"]',
      'link[rel="shortcut icon"]',
      'link[rel="icon",sizes="16x16"]',
      'link[rel="icon",sizes="32x32"]',
      'meta[name="msapplication-TileColor"]',
      'meta[name="msapplication-TileImage"]',
      'link[rel="manifest"]',
      'meta[name="theme-color"]',
      'link[rel="icon",sizes="192x192"]',
      'link[rel="icon",sizes="228x228"]',
      'meta[property="og:image"]',
      'link[rel="yandex-tableau-widget"]']

    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          desktop_browser: {},
          ios: {
            picture_aspect: :background_and_margin,
            background_color: '#ff0099',
            margin: '10%'
          },
          windows: {
            picture_aspect: :white_silhouette,
            background_color: '#789abc'
          },
          firefox_app: {
            picture_aspect: :circle,
            keep_picture_in_circle: true,
            circle_inner_margin: 1,
            background_color: '#aabbcc',
            manifest: {
              app_name: 'An app',
              app_description: 'This is an app',
              developer_name: 'Me',
              developer_url: 'http://example.com/me'
            }
          },
          android_chrome: {
            picture_aspect: :shadow,
            theme_color: '#99abcd',
            manifest: {
              name: 'Another app',
              display: :standalone,
              orientation: :landscape,
              start_url: 'http://example.com/an_app'
            }
          },
          coast: {
            picture_aspect: :background_and_margin,
              background_color: '#97af12',
              margin: '30%'
          },
          open_graph: {
            picture_aspect: :background_and_margin,
            background_color: '#794613',
            margin: '20%',
            ratio: '1.91:1'
          },
          yandex_browser: {
            background_color: '#ccdd00',
            manifest: {
              show_title: true,
              version: '123.456.789'
            }
          }
        }
      }
    }, expected_dir_path, expected_html, false, expected_replaced_markups)
  end

  def test_1_compressed
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          desktop_browser: {},
          ios: {
            picture_aspect: :background_and_margin,
            background_color: '#ff0099',
            margin: '10%'
          },
          windows: {
            picture_aspect: :white_silhouette,
            background_color: '#789abc'
          },
          firefox_app: {
            picture_aspect: :circle,
            keep_picture_in_circle: true,
            circle_inner_margin: 1,
            background_color: '#aabbcc',
            manifest: {
              app_name: 'An app',
              app_description: 'This is an app',
              developer_name: 'Me',
              developer_url: 'http://example.com/me'
            }
          },
          android_chrome: {
            picture_aspect: :shadow,
            theme_color: '#99abcd',
            manifest: {
              name: 'Another app',
              display: :standalone,
              orientation: :landscape,
              start_url: 'http://example.com/an_app'
            }
          },
          coast: {
            picture_aspect: :background_and_margin,
              background_color: '#97af12',
              margin: '30%'
          },
          open_graph: {
            picture_aspect: :background_and_margin,
            background_color: '#794613',
            margin: '20%',
            ratio: '1.91:1'
          },
          yandex_browser: {
            background_color: '#ccdd00',
            manifest: {
              show_title: true,
              version: '123.456.789'
            }
          }
        },
        settings: {
          compression: 5,
          scaling_algorithm: "Mitchell"
        }
      }
    }, expected_dir_path, <<EOT
<link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="/apple-touch-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="/apple-touch-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="/apple-touch-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="/apple-touch-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon-180x180.png">
<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="230x230" href="/favicon-230x230.png">
<link rel="icon" type="image/png" sizes="192x192" href="/android-chrome-192x192.png">
<link rel="icon" type="image/png" sizes="228x228" href="/coast-228x228.png">
<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
<link rel="manifest" href="/site.webmanifest">
<link rel="yandex-tableau-widget" href="/yandex-browser-manifest.json">
<meta property="og:image" content="/open-graph.png">
<meta name="msapplication-TileColor" content="#789abc">
<meta name="msapplication-TileImage" content="/mstile-144x144.png">
<meta name="theme-color" content="#99abcd">
EOT
    )
  end

  def test_svg
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :inline,
          content: to_base64("resources/master_svg.svg")
        },
        favicon_design: {
          desktop_browser: {},
          ios: {
            picture_aspect: :background_and_margin,
            background_color: '#ff0099',
            margin: '10%'
          },
          windows: {
            picture_aspect: :white_silhouette,
            background_color: '#789abc'
          },
          firefox_app: {
            picture_aspect: :circle,
            keep_picture_in_circle: true,
            circle_inner_margin: 1,
            background_color: '#aabbcc',
            manifest: {
              app_name: 'An app',
              app_description: 'This is an app',
              developer_name: 'Me',
              developer_url: 'http://example.com/me'
            }
          },
          android_chrome: {
            picture_aspect: :shadow,
            theme_color: '#99abcd',
            manifest: {
              name: 'Another app',
              display: :standalone,
              orientation: :landscape,
              start_url: 'http://example.com/an_app'
            }
          },
          coast: {
            picture_aspect: :background_and_margin,
              background_color: '#97af12',
              margin: '30%'
          },
          open_graph: {
            picture_aspect: :background_and_margin,
            background_color: '#794613',
            margin: '20%',
            ratio: '1.91:1'
          },
          yandex_browser: {
            background_color: '#ccdd00',
            manifest: {
              show_title: true,
              version: '123.456.789'
            }
          }
        }
      }
    }, expected_dir_path, <<EOT
<link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="/apple-touch-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="/apple-touch-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="/apple-touch-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="/apple-touch-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon-180x180.png">
<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="230x230" href="/favicon-230x230.png">
<link rel="icon" type="image/png" sizes="192x192" href="/android-chrome-192x192.png">
<link rel="icon" type="image/png" sizes="228x228" href="/coast-228x228.png">
<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
<link rel="manifest" href="/site.webmanifest">
<link rel="yandex-tableau-widget" href="/yandex-browser-manifest.json">
<meta property="og:image" content="/open-graph.png">
<meta name="msapplication-TileColor" content="#789abc">
<meta name="msapplication-TileImage" content="/mstile-144x144.png">
<meta name="theme-color" content="#99abcd">
EOT
    )
  end

  # See https://github.com/RealFaviconGenerator/grunt-real-favicon/issues/12
  def test_issue_12
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :inline,
          content: "#{to_base64('resources/master_svg_issue_12.svg')}"
        },
        favicon_design: {
          desktop_browser: {},
          ios: {
               picture_aspect: 'background_and_margin',
               background_color: '#000000',
               margin: 7,
           },
           android_chrome: {
               picture_aspect: 'background_and_margin',
               background_color: '#000000',
               margin: 7,
               manifest: {
                   name: 'Slevomat.cz',
                   display: 'browser'
               },
           },
           coast: {
               picture_aspect: 'background_and_margin',
               background_color: '#000000',
               margin: 7,
           },
           windows: {
               picture_aspect: 'no_change',
               background_color: '#000000',
           }
        }
      }
    }, expected_dir_path, <<EOT
<link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="/apple-touch-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="/apple-touch-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="/apple-touch-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="/apple-touch-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon-180x180.png">
<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="230x230" href="/favicon-230x230.png">
<link rel="icon" type="image/png" sizes="192x192" href="/android-chrome-192x192.png">
<link rel="icon" type="image/png" sizes="228x228" href="/coast-228x228.png">
<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
<link rel="manifest" href="/site.webmanifest">
<meta name="msapplication-TileColor" content="#000000">
<meta name="msapplication-TileImage" content="/mstile-144x144.png">
EOT
    )
  end

  def test_version
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          desktop_browser: {},
          ios: {
            picture_aspect: :background_and_margin,
            background_color: '#ff0099',
            margin: '10%'
          },
          windows: {
            picture_aspect: :white_silhouette,
            background_color: '#789abc'
          },
          firefox_app: {
            picture_aspect: :circle,
            keep_picture_in_circle: true,
            circle_inner_margin: 1,
            background_color: '#aabbcc',
            manifest: {
              app_name: 'An app',
              app_description: 'This is an app',
              developer_name: 'Me',
              developer_url: 'http://example.com/me'
            }
          },
          android_chrome: {
            picture_aspect: :shadow,
            theme_color: '#99abcd',
            manifest: {
              name: 'Another app',
              display: :standalone,
              orientation: :landscape,
              start_url: 'http://example.com/an_app'
            }
          },
          coast: {
            picture_aspect: :background_and_margin,
              background_color: '#97af12',
              margin: '30%'
          },
          open_graph: {
            picture_aspect: :background_and_margin,
            background_color: '#794613',
            margin: '20%',
            ratio: '1.91:1'
          },
          yandex_browser: {
            background_color: '#ccdd00',
            manifest: {
              show_title: true,
              version: '123.456.789'
            }
          }
        },
        versioning: {
          param_name: 'version',
          param_value: '123ABC'
        }
      }
    }, expected_dir_path, <<EOT
<link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-57x57.png?version=123ABC">
<link rel="apple-touch-icon" sizes="60x60" href="/apple-touch-icon-60x60.png?version=123ABC">
<link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-72x72.png?version=123ABC">
<link rel="apple-touch-icon" sizes="76x76" href="/apple-touch-icon-76x76.png?version=123ABC">
<link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114x114.png?version=123ABC">
<link rel="apple-touch-icon" sizes="120x120" href="/apple-touch-icon-120x120.png?version=123ABC">
<link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144x144.png?version=123ABC">
<link rel="apple-touch-icon" sizes="152x152" href="/apple-touch-icon-152x152.png?version=123ABC">
<link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon-180x180.png?version=123ABC">
<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png?version=123ABC">
<link rel="icon" type="image/png" sizes="230x230" href="/favicon-230x230.png?version=123ABC">
<link rel="icon" type="image/png" sizes="192x192" href="/android-chrome-192x192.png?version=123ABC">
<link rel="icon" type="image/png" sizes="228x228" href="/coast-228x228.png?version=123ABC">
<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png?version=123ABC">
<link rel="manifest" href="/site.webmanifest?version=123ABC">
<link rel="shortcut icon" href="/favicon.ico?version=123ABC">
<link rel="yandex-tableau-widget" href="/yandex-browser-manifest.json?version=123ABC">
<meta property="og:image" content="/open-graph.png?version=123ABC">
<meta name="msapplication-TileColor" content="#789abc">
<meta name="msapplication-TileImage" content="/mstile-144x144.png?version=123ABC">
<meta name="theme-color" content="#99abcd">
EOT
    )
  end

  def test_svg_small
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :inline,
          content: to_base64("resources/master_svg_small.svg")
        },
        favicon_design: {
          desktop_browser: {},
          ios: {
            picture_aspect: :background_and_margin,
            background_color: '#ff0099',
            margin: '10%'
          },
          windows: {
            picture_aspect: :no_change,
            background_color: '#789abc'
          },
          firefox_app: {
            picture_aspect: :circle,
            keep_picture_in_circle: true,
            circle_inner_margin: 1,
            background_color: '#aabbcc',
            manifest: {
              app_name: 'An app',
              app_description: 'This is an app',
              developer_name: 'Me',
              developer_url: 'http://example.com/me'
            }
          },
          android_chrome: {
            picture_aspect: :shadow,
            theme_color: '#99abcd',
            manifest: {
              name: 'Another app',
              display: :standalone,
              orientation: :landscape,
              start_url: 'http://example.com/an_app'
            }
          },
          coast: {
            picture_aspect: :background_and_margin,
              background_color: '#97af12',
              margin: '30%'
          },
          open_graph: {
            picture_aspect: :background_and_margin,
            background_color: '#794613',
            margin: '20%',
            ratio: '1.91:1'
          },
          yandex_browser: {
            background_color: '#ccdd00',
            manifest: {
              show_title: true,
              version: '123.456.789'
            }
          }
        }
      }
    }, expected_dir_path, <<EOT
<link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="/apple-touch-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="/apple-touch-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="/apple-touch-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="/apple-touch-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon-180x180.png">
<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="230x230" href="/favicon-230x230.png">
<link rel="icon" type="image/png" sizes="192x192" href="/android-chrome-192x192.png">
<link rel="icon" type="image/png" sizes="228x228" href="/coast-228x228.png">
<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
<link rel="manifest" href="/site.webmanifest">
<link rel="yandex-tableau-widget" href="/yandex-browser-manifest.json">
<meta property="og:image" content="/open-graph.png">
<meta name="msapplication-TileColor" content="#789abc">
<meta name="msapplication-TileImage" content="/mstile-144x144.png">
<meta name="theme-color" content="#99abcd">
EOT
    )
  end
end
