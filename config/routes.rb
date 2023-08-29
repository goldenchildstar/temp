Rails.application.routes.draw do
  root to: proc { [200, {}, ['Alive']] }

  match '/auth/:provider/callback'        => 'omniauth#callback',    as: :omniauth_callback, via: [:get, :post]
  get   '/auth/failure'                   => 'omniauth#failure',     as: :omniauth_failure

  # Entry point for the Zebra splash pages.
  # "organization" - the unique identifier given to the client company.
  # "page_path" - the hierachical path to the unique splash page
  get    '/splash/aruba/:organization/*page_path'  => 'splash/aruba#index',                as: :aruba_splash
  get    '/splash/meraki/sms/:organization/*page_path' => 'splash/verification/sms#index', as: :meraki_splash_sms
  post   '/splash/meraki/sms/register'                 => 'splash/verification/sms#register', as: :meraki_sms_registration
  post   '/splash/meraki/sms/verify'                   => 'splash/verification/sms#verify_code', as: :meraki_sms_verification
  get    '/splash/meraki/:organization/*page_path' => 'splash/meraki#index',               as: :meraki_splash


  get    '/splash/sponsor/22carnot/sponsor'           => 'splash/carnot_sponsor#sponsor',                 as: :carnot_sponsor_splash
  post   '/splash/sponsor/22carnot/register'          => 'splash/carnot_sponsor#register',                as: :carnot_sponsor_registration
  get    '/splash/sponsor/22carnot/wait'              => 'splash/carnot_sponsor#wait',                    as: :carnot_sponsor_wait
  get    '/splash/sponsor/22carnot/verify/:key'       => 'splash/carnot_sponsor#check_verification',      as: :carnot_sponsor_wait_verification
  get    '/splash/sponsor/22carnot/code'              => 'splash/carnot_sponsor#access_code',             as: :carnot_access_code
  post   '/splash/sponsor/22carnot/code_verification' => 'splash/carnot_sponsor#verify_code',             as: :carnot_access_code_verification
  get    '/splash/sponsor/22carnot/authorize/:key'    => 'splash/carnot_sponsor#authorize_registration', as: :carnot_sponsor_authorization

  get    '/splash/sponsor/ftp/sponsor'           => 'splash/ftp_sponsor#sponsor',                 as: :ftp_sponsor_splash
  post   '/splash/sponsor/ftp/register'          => 'splash/ftp_sponsor#register',                as: :ftp_sponsor_registration
  get    '/splash/sponsor/ftp/wait'              => 'splash/ftp_sponsor#wait',                    as: :ftp_sponsor_wait
  get    '/splash/sponsor/ftp/verify/:key'       => 'splash/ftp_sponsor#check_verification',      as: :ftp_sponsor_wait_verification
  get    '/splash/sponsor/ftp/code'              => 'splash/ftp_sponsor#access_code',             as: :ftp_access_code
  post   '/splash/sponsor/ftp/code_verification' => 'splash/ftp_sponsor#verify_code',             as: :ftp_access_code_verification
  get    '/splash/sponsor/ftp/authorize/:key'    => 'splash/ftp_sponsor#authorization_duration', as: :ftp_sponsor_authorization
  post   '/splash/sponsor/ftp/authorize/:key'    => 'splash/ftp_sponsor#authorize_registration', as: :ftp_sponsor_authorize

  get    '/splash/pages/*template_path'            => 'splash#template_path',              as: :page_template
  get    '/splash/:organization/(:page)'           => 'splash#index',                      as: :splash
  get    '/page/*path'                             => 'splash#page',                       as: :page
  get    '/external/authorize'                     => 'splash/external_splash#authorize',  as: :external_authorize
  get    '/external/:organization/(:page)'         => 'splash/external_splash#redirect',   as: :external_splash
  post   '/registration/(:type)'                   => 'splash/registration#register',      as: :registration
  get    '/finished'                               => 'splash/post_authorization#index',   as: :post_authorization

  get    '/optout'                                 => 'splash#authorize',                  as: :optout
  get    '/aruba/authorize'                        => 'splash/aruba#authorize',            as: :aruba_authorization

  get    '/alive'                                  => 'splash#alive',                      as: :health_check
  get    '/parameters'                             => 'internal#debug',                    as: :parameter_debug

  # Client specific
  post '/email_registration'                       => 'splash/email_registration#register',   as: :email_registration

end
