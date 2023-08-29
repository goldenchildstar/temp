module ArubaHelper
  def aruba_alt_page(page_path, page_params=params)
    aruba_splash_url(page_params.symbolize_keys.merge({page_path: page_path}))
  end
end
