export PATH=./bin:$DOTFILES/bin:$PATH

PYTHONPATH=$PYTHONPATH:/opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages
if [[ -a $(which brew) ]]
then
  PYTHONPATH=$PYTHONPATH:$(brew --prefix)/lib/python2.7/site-packages
fi
export PYTHONPATH
