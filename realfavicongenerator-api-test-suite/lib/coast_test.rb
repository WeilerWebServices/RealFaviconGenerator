require 'rfg_api_test'

class CoastTest < RFGAPITest
  def test_basic
    favicon_generation({
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :url,
          url: "http://realfavicongenerator.net/demo_favicon.png"
        },
        favicon_design: {
          coast: {}
        }
      }
    }, expected_dir_path, <<EOT
<link rel="icon" type="image/png" sizes="228x228" href="/coast-228x228.png">
EOT
    )

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
          coast: {}
        }
      }
    }, expected_dir_path, <<EOT
<link rel="icon" type="image/png" sizes="228x228" href="/path/to/icons/coast-228x228.png">
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
          coast: {
            picture_aspect: :background_and_margin,
            margin: '18%',
            background_color: '#9912fa'
          }
        }
      }
    }, expected_dir_path, <<EOT
<link rel="icon" type="image/png" sizes="230x230" href="/favicon-230x230.png">
<link rel="icon" type="image/png" sizes="228x228" href="/coast-228x228.png">
EOT
    )
  end
end
