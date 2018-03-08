defmodule PetmeetWeb.Services.Authenticator do
  import Joken
  import Comeonin.Bcrypt
  alias Petmeet.Accounts

  def authenticate(username, password) do
    case Accounts.get_pet_by_username(username) do
      nil ->
        {:error, "No Match Found"}
      pet ->
        if checkpw(password, pet.encrypted_password) do
          token = generate_token(pet)
          {:ok, %{token: token, pet: pet}}
        else
          {:error, "invalid user"}
        end
    end
  end

  def generate_token(pet) do
    my_token =
      %{pet_id: pet.id}
      |> token()
      |> with_signer(hs256(Application.get_env(:petmeet, PetmeetWeb.Endpoint)[:secret_key_base]))
      |> with_iat(current_time())
      |> sign()
      |> get_compact()
  end
end
