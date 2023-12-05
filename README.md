# Call-of-duty-blackops3-custom-RainbowSix-Extraction-style-hud
This is a custom hud for Call of Duty Black OPS 3,Based on Kingslayer Kyle's LUA code

FOR COPYRIGHT,I CANNOT PUBSLISH IMAGES AND FONTS ON GITHUB,YOU CAN DOWNLOAD THESE FILES AT DEVRAW

FIRST YOU MUST DOWNLOAD L3akMod from https://wiki.modme.co/wiki/black_ops_3/lua_(lui)/Installation.html and install it ,OR THE MOD TOOL CANNOT COMPILES LUA FILES!(console will show "lua not support")

Put file "converter_gdt_dirs_0.txt" in ROOT/bin;

Put file "c_r6e_hud.gdt" in ROOT/source_data;

Put "ui" folder in ROOT/usermaps/zm_yourmap;

Put 3 GSC files in ROOT/usermaps/zm_yourmap/scripts/zm;

Put "r6e_hud.zpkg" in ROOT/usermaps/zm_yourmap/zone_source;

Create a new folder named "fonts" in ROOT/usermaps/zm_yourmap,and put all font files in it;

in your mapname.gsc, add #using scripts/zm/_zm_r6e_hud; and #using scripts/zm/_zm_r6ehud_hitmarks; in your preprocessor;

in your mapname.csc, add #using scripts/zm/_zm_r6e_hud; in your preprocessor;

in your mapname.zone,add include,r6e_hud

Download image files from DEVRAW,put the "_custom" folder in you game root;

To check this hud installed successful or not:

open APE,search GDT "c_r6e_hud",if it exsits and contains all image files,it means you have installed it correctly.

Finally,Link your map and run.

credits:
Ubisoft Montreal

Activision,Treyarch,Infinity Ward,SledgeHammer

MizugakiIsla

SG4Y

Kingslayer Kyle

lilrifa

MrChuse

AmberLeaf

OldManCats

Scobalula

Ardivee
JariK
Warden

