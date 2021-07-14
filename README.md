# Expensable CLI

> Before starting!
>
> 1. Create a new folder with the project name and open it from VS Code
>
> 2. From the VS Code terminal run the next docker command
>
> ```powershell
> docker container run \
> --name ruby \
> -it \
> -v $(pwd):/app \
> -v ssh:/root/.ssh \
> -v bundle:/usr/local/bundle \
> -e GIT_USER_NAME=<your_username> \
> -e GIT_USER_EMAIL=<your_email> \
> --rm \
> codeableorg/ruby
> ```
>
> 3. Clone the repository of your work team
>
> ```powershell
> $ git clone git@github.com:codeableorg/calencli-c4w1-xxx.git .
> ```
>
> 4.  Run some initialization scripts
>
> ```powershell
> $ bootstrap
> ```
>
> 5.  Install some necessary gems for rubocop to work properly
>
> ```powershell
> $ bundle install
> ```
>
> ready, you can work on your project!

Looking for the project instructions? Find them on [this notion doc](https://www.notion.so/ableco/Team-Expensable-CLI-642b50457d494412a24fab308e8d098d)

To disable temporarily any Rubocop convention:

```
# rubocop:disable Metrics/AbcSize
def complex_and_irreducible_method(that, receive, a, lot, of, params)
  ...
  ...
  ...
end
# rubocop:enable Metrics/AbcSize
```

To disable them, use the convention that Rubocop is complaining about. _Metrics/AbcSize_ is just an example.

We have created a couple of files for you. You can create as many extra files as you consider but `game.rb` should be kept as the main one.

After commiting your changes, push them changes to your Github repo. We will grade you based on the code uploaded to the cloud.
