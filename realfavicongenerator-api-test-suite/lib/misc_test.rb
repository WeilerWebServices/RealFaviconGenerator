require 'rfg_api_test'

class MiscTest < RFGAPITest
  def test_non_square
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :inline,
          content: "#{to_base64('resources/non_square_landscape_large.png')}"
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

  def test_non_square_specific
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          desktop_browser: {
            master_picture: {
              type: :inline,
              content: "#{to_base64('resources/non_square_landscape_large.png')}"
            }
          }
        }
      }
    }, expected_dir_path, <<EOT
<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
EOT
    )
  end
end
