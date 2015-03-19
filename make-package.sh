if test -z "$(git status --porcelain --untracked-files=no)" ; then
  cd node
  git rm .gitignore 
  rm -rf node_modules/
  npm install
  cd ..
  git add --all
  NODE=$(which node || which nodejs);
  VERSION=$("$NODE" -e 'var pkg = require("./package.json"); console.log(pkg.version);')
  git stash save "package-$VERSION"
  git archive --worktree-attributes --format zip -9 -o "brackets-less-autocompile-$VERSION.zip" stash@{0}
  git stash drop
else
  echo "Working directory is dirty..."
fi
