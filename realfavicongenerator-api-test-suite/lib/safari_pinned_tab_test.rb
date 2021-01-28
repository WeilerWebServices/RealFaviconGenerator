require 'rfg_api_test'

class SafariPinnedTabTest < RFGAPITest
  def test_basic
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          safari_pinned_tab: {}
        }
      }
    }, expected_dir_path, <<EOT
<link rel="mask-icon" href="/safari-pinned-tab.svg" color="#ffffff">
EOT
    )
  end

  def test_black_and_white
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          safari_pinned_tab: {
            picture_aspect: 'black_and_white',
            threshold: 80,
            theme_color: '#456987'
          }
        }
      }
    }, expected_dir_path, <<EOT
<link rel="mask-icon" href="/safari-pinned-tab.svg" color="#456987">
EOT
    )
  end
  
  def test_silhouette
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          safari_pinned_tab: {
            picture_aspect: 'silhouette',
            theme_color: '#abc456'
          }
        }
      }
    }, expected_dir_path, <<EOT
<link rel="mask-icon" href="/safari-pinned-tab.svg" color="#abc456">
EOT
    )
  end
  
  def test_no_change
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :inline,
          content: to_base64("resources/master_svg.svg")
        },
        favicon_design: {
          safari_pinned_tab: {
            picture_aspect: 'no_change',
            theme_color: '#ab12cd'
          }
        }
      }
    }, expected_dir_path, <<EOT
<link rel="mask-icon" href="/safari-pinned-tab.svg" color="#ab12cd">
EOT
    )
  end

end
