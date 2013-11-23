module SomeModule
  # How to use functions in Chef recipes.
  # You can call this function as SomeModule.some_helper_fun ( :x )
  def some_helper_fun( some_arg )
    new_string = some_arg + :new_string_part
  end
  # Kudos to Draco Ater
  # http://stackoverflow.com/questions/15595144/dry-within-a-chef-recipe
end
