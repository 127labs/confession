defmodule Facebook do
  use Maxwell.Builder

  middleware Maxwell.Middleware.BaseUrl, "https://graph.facebook.com/"
  middleware Maxwell.Middleware.Opts, []
  middleware Maxwell.Middleware.Json,
    encode_content_type: MIME.type("json"),
    encode_func: &JSON.encode/1,
    decode_func: &JSON.decode/1
  middleware Maxwell.Middleware.Logger

  adapter Maxwell.Adapter.Hackney

  def access_token do
    Application.fetch_env!(:confession, :fb_page_access_token)
  end

  def verification_token do
    Application.fetch_env!(:confession, :fb_verification_token)
  end

  def id do
    Application.fetch_env!(:confession, :fb_id)
  end

  defmacro __using__(_) do
    quote do
      import Facebook

      alias Maxwell.Conn
      alias Facebook.{
        Message,
        Post,
        Feed,
        Event,
      }
    end
  end
end
