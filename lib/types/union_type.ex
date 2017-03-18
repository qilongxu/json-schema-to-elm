defmodule JS2E.Types.UnionType do
  @moduledoc ~S"""
  Represents a custom 'union' type definition in a JSON schema.

  JSON Schema:

      "favoriteNumber": {
        "type": ["number", "integer", "null"]
      }

  Elixir intermediate representation:

      %UnionType{name: "favoriteNumber",
                 path: ["#", "favoriteNumber"],
                 types: ["number", "integer", "null"]}

  Elm code generated:

  - Type definition

      type FavoriteNumber
          = FavoriteNumber_F Float
          | FavoriteNumber_I Int

  - Decoder definition

      favoriteNumberDecoder : Decoder (Maybe FavoriteNumber)
      favoriteNumberDecoder =
          oneOf
              [ null Nothing
              , float |> andThen (succeed << FavoriteNumber_F)
              , int |> andThen (succeed << FavoriteNumber_I)
              ]

  - Usage

      |> custom (field "favoriteNumber" favoriteNumberDecoder)

  """

  alias JS2E.TypePath

  @type t :: %__MODULE__{name: String.t,
                         path: TypePath.t,
                         types: [String.t]}

  defstruct [:name, :path, :types]
end
