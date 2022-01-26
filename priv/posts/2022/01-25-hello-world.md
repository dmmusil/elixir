%{
title: "Elixir Blog on Fly.io",
author: "Dylan",
tags: ~w(hello welcome),
description: "Elixir Blog on Fly.io"
}

---

I've been slowly learning Elixir over the last year. This year I'm injured, unable to ski, and have a week off while it's too cold to do anything else. So I jumped back into Elixir after about 6 months away from it.

What a time to return! All the new features in LiveView are amazing and really improve the experience. With the Wordle craze in full swing I knew exactly what I was building to try them out. Then there's the announcement from [Fly.io](https://fly.io){:target="\_blank"} about the ability to host an app and a Postgres database for no cost: [Free Postgres](https://fly.io/blog/free-postgres/){:target="\_blank"}. That's what this site is running on and I highly recommend it. I'll spend the rest of this post discussing how I built and deploy the app automatically to fly on each commit.

### Wordle clone with LiveView

I won't detail too much what's new, but there's a nice video from ElixirConf that got me excited: [The Future of Full-stack](https://www.youtube.com/watch?v=Of1phFsC4ZI){:target="\_blank"}. For someone coming from .NET who is not interested in front-end frameworks and tooling, or writing any Javascript really, I am very interested to see what happens with LiveView over the next couple years. Blazor has me interested, but it's just not ready for the big time yet.

To take the new experience for a spin I made a very rough but correct Wordle clone. It's at [/wordle/:word](/wordle/apple){:target="\_blank"}. The URL parameter is the hidden word and there's no word list so you can both provide and guess nonsense words.

I just challenged myself to solve the guess evaluation functionally. I see lots of examples of people creating a naive guess evaluation algorithm that fails to produce correct output when letters repeat. Try guessing `poppy` at the link provided to see what I mean. The secret word is `apple` and `poppy` has one `p` that's correctly positioned and two that aren't. Only one of the `p`s should be yellow since there are only two in the secret word. Many implementations I've seen will falsely color both of the `p`s yellow in addition to the correct `p` that's green.

The evaluation algorithm is [here](https://github.com/dmmusil/elixir/blob/main/lib/arcade/wordle/wordle.ex){:target="\_blank"}

### The blog, courtesy of Dashbit

I figured building a blog would be a good learning exercise. But I did one Google search and found NimblePublisher via the [Dashbit blog](https://dashbit.co/blog/welcome-to-our-blog-how-it-was-made){:target="\_blank"} and here we are.

It took an hour to setup and configured. No database required!

### Deploying to Fly

Fly makes it easy. Sign up, provide a credit card, `brew install superfly/tap/flyctl`, and `fly launch`. That's it.

To activate CD with a Github action is similarly easy. `fly auth token` gets you a token to store in your repository secrets. Then use this YAML:

```
name: Elixir CI

on:
  push:
    branches: [main]

jobs:
  build:
    name: Build and test
    runs-on: ubuntu-latest
    env:
      FLY_API_TOKEN: ${{secrets.FLY_TOKEN}}
    services:
      postgres:
        image: postgres
        env:
          POSTGRES_PASSWORD: postgres
          POSTGRES_USER: postgres
        ports:
          - "5432:5432"
    steps:
      - uses: actions/checkout@v2
      - name: Set up Elixir
        uses: erlef/setup-beam@988e02bfe678367a02564f65ca2e37726dc0268f
        with:
          elixir-version: "1.12.3" # Define the elixir version [required]
          otp-version: "24.1" # Define the OTP version [required]
      - name: Restore dependencies cache
        uses: actions/cache@v2
        with:
          path: deps
          key: ${{ runner.os }}-mix-${{ hashFiles('**/mix.lock') }}
          restore-keys: ${{ runner.os }}-mix-
      - name: Install dependencies
        run: mix deps.get
      - name: Run tests
        run: mix test
      - name: Deploy to Fly
        uses: superfly/flyctl-actions@1.1
        with:
          args: "deploy"
```

That's it. You're deploying automatically.
