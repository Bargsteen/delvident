# delvident

delvident is an online tool for easily creating and managing glossaries within teams.

## Usage
### Build code

> ```npm install```

> ```npm run dev```

### Run Dev Server

> ```npm start```

## Hot code reload with purescript code

At the end of the previous command, you will have a development server
which will watch for changes, and automatically reload the web page.
This mechanism only works with JS changes.

However, in practice, your IDE should automatically recompile Purescript to
Javascript on every change, which will be picked up by the development server.
So you get immediate recompilation even with Purescript.

### Build production artifacts

> ```npm run prod```

## Roadmap

### v0.1
- [ ] Add terms with definitions
- [ ] Display lists of terms, sorted by name

### v0.2
- [ ] Edit terms
- [ ] Add terms *without* definitions
- [ ] Give confidence in definition

### v0.3
- [ ] Link to other terms easily
- [ ] Show term with missing definitions

### v0.4
- [ ] Admin can create users (perhaps directly in db)
- [ ] Login (for added safety)

### v0.5
- [ ] Add tags to terms
- [ ] Navigate with by tags

### v0.6
- [ ] Show definitions of related terms on hover.

### v0.7
- [ ] Add images and perhaps markdown to definitions
