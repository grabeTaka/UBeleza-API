class TokensController < Doorkeeper::TokensController
  def create
    p '121212121212121212121212121212121212121212121212121212121212121212121212121212121212'
    super
  rescue Errors::DoorkeeperError => e
    handle_token_exception(e)
  end
end
