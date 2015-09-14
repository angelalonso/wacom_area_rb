# wacom_area_rb
snippet to manually set the boundaries for a tablet(e.g. wacom bamboo), written in Ruby with Gosu and a bit of QT

The purpose is to improve the resolution of a small tablet, such as the bamboo pad (for which I'm writing this) on the go.

CURRENT STATUS: Needs to be callibrated to translate area from the screen resolution to what xsetwacom understands



REQUIREMENTS (UBUNTU TESTED)

sudo apt-get install ruby ruby-dev ruby-qt4 build-essential libsdl2-dev libsdl2-ttf-dev libpango1.0-dev \
                     libgl1-mesa-dev libfreeimage-dev libopenal-dev libsndfile-dev

sudo gem install gosu

