require 'social/social_api_test'

class OpenGraphTest < SocialApiTest
  def test_basic
    social_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          facebook_open_graph: {}
        }
      }
    }, expected_dir_path, <<EOT
<meta property="og:image" content="/og-image.jpg">
<meta property="og:image:height" content="395">
<meta property="og:image:width" content="754">
EOT
    )
  end

  def test_all_fields
    social_generation({
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
          facebook_open_graph: {
            title: "The title",
            description: "The description",
            url: "http://www.example.com/my_page",
            facebook_app_id: "456abc",
            type: "article",
            site_name: "Sample Site",
            locale: "en-US",
            image: {
              left: 50,
              top: 50,
              scale: 0.8,
              ratio: :square
            }
          }
        }
      }
    }, expected_dir_path, <<EOT
<meta property="og:image" content="/path/to/icons/og-image.jpg">
<meta property="og:image:width" content="279">
<meta property="og:image:height" content="279">
<meta property="og:app_id" content="456abc">
<meta property="og:site_name" content="Sample Site">
<meta property="og:description" content="The description">
<meta property="og:title" content="The title">
<meta property="og:type" content="article">
<meta property="og:locale" content="en-US">
<meta property="og:url" content="http://www.example.com/my_page">
EOT
    )
  end

end
