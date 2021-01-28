require 'rfg_api_test'

class GlobalTest < RFGAPITest
  def test_1
    request = {
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :inline,
          content: "#{to_base64('resources/master_1_120x120.png')}"
        },
        favicon_design: {
          windows: {
            picture_aspect: :white_silhouette,
            background_color: '#789abc',
            on_conflict: :override,
            assets: {
              windows_80_ie_10_tile: true,
              windows_10_ie_11_edge_tiles: {
                small: true, medium: true, big: true, rectangle: true
              }
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
          }
        },
        settings: {
          compression: 2,
          scaling_algorithm: 'NearestNeighbor',
          error_on_image_too_small: false,
          # Wait, what is this undocumented parameter?
          # When set to true, it ask RFG to post back the request in the response.
          # In a non-interactive scenario, it doesn't make any sense
          # (although is is interesting in an interactive scenario)
          # Here it is usefull because it allows us to test the feature.
          get_api_request: true,
          readme_file: true,
			    html_code_file: false,
          use_path_as_is: false
        },
        versioning: {
          param_name: 'abc',
          param_value: '123'
        }
      }
    }

    response = RestClient.post("https://realfavicongenerator.net/api/favicon", request.to_json, content_type: :json)

    response = JSON.parse response.body

    assert_equal 'success', response['favicon_generation_result']['result']['status']

    # Returned request is not exactly identical to the original one
    request[:favicon_generation][:settings].delete :get_api_request

    assert_equal JSON.parse(request.to_json),
      JSON.parse(response['favicon_generation_result']['non_interactive_request'])
  end

  def test_2
    request = {
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :inline,
          content: "#{to_base64('resources/master_1_120x120.png')}"
        },
        favicon_design: {
          windows: {
            picture_aspect: :white_silhouette,
            background_color: '#789abc',
            on_conflict: :override,
            assets: {
              windows_80_ie_10_tile: true,
              windows_10_ie_11_edge_tiles: {
                small: true, medium: true, big: true, rectangle: true
              }
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
          }
        },
        settings: {
          compression: 2,
          scaling_algorithm: 'NearestNeighbor',
          error_on_image_too_small: false,
          # Wait, what is this undocumented parameter?
          # When set to true, it ask RFG to post back the request in the response.
          # In a non-interactive scenario, it doesn't make any sense
          # (although is is interesting in an interactive scenario)
          # Here it is usefull because it allows us to test the feature.
          get_api_request: true,
          readme_file: false,
          use_path_as_is: true
        },
        versioning: {
          param_name: 'abc',
          param_value: '123'
        }
      }
    }

    response = RestClient.post("https://realfavicongenerator.net/api/favicon", request.to_json, content_type: :json)

    response = JSON.parse response.body

    assert_equal 'success', response['favicon_generation_result']['result']['status']

    # Returned request is not exactly identical to the original one
    request[:favicon_generation][:settings].delete :get_api_request

    assert_equal JSON.parse(request.to_json),
      JSON.parse(response['favicon_generation_result']['non_interactive_request'])
  end

  def test_3
    request = {
      favicon_generation: {
        api_key: "87d5cd739b05c00416c4a19cd14a8bb5632ea563",
        master_picture: {
          type: :inline,
          content: "#{to_base64('resources/master_1_120x120.png')}"
        },
        favicon_design: {
          windows: {
            picture_aspect: :white_silhouette,
            background_color: '#789abc',
            on_conflict: :override,
            assets: {
              windows_80_ie_10_tile: true,
              windows_10_ie_11_edge_tiles: {
                small: true, medium: true, big: true, rectangle: true
              }
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
          }
        },
        settings: {
          compression: 2,
          scaling_algorithm: 'NearestNeighbor',
          error_on_image_too_small: false,
          # Wait, what is this undocumented parameter?
          # When set to true, it ask RFG to post back the request in the response.
          # In a non-interactive scenario, it doesn't make any sense
          # (although is is interesting in an interactive scenario)
          # Here it is usefull because it allows us to test the feature.
          get_api_request: true,
          html_code_file: true
        },
        versioning: {
          param_name: 'abc',
          param_value: '123'
        }
      }
    }

    response = RestClient.post("https://realfavicongenerator.net/api/favicon", request.to_json, content_type: :json)

    response = JSON.parse response.body

    assert_equal 'success', response['favicon_generation_result']['result']['status']

    # Returned request is not exactly identical to the original one
    request[:favicon_generation][:settings].delete :get_api_request

    assert_equal JSON.parse(request.to_json),
      JSON.parse(response['favicon_generation_result']['non_interactive_request'])
  end
end
