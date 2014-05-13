<?php /*


[ImageMagick]
Filters[]=thumb=-resize 'x%1' -resize '%1x<' -resize 50%
Filters[]=centerimg=-gravity center -crop %1x%2+0+0 +repage
Filters[]=strip=-strip
Filters[]=sharpen=-sharpen 0.5
Filters[]=play_watermark=extension/opencontent/design/standard/images/i-play-2.png -composite -gravity Center
Filters[]=play_watermark_big=extension/opencontent/design/ftcoop_base/images/icons/play-btn.png -composite -gravity Center
Filters[]=geometry/scalemin=-geometry %1x%2^
Filters[]=geometry/galleryscale=-gravity center -background %1 -extent %2x%3

[AliasSettings]
AliasList[]=squarethumb
AliasList[]=imagefullwide

[squarethumb]
Reference=original
Filters[]
Filters[]=geometry/scalewidthdownonly=200
Filters[]=centerimg=100;100

[imagefullwide]
Reference=original
Filters[]
Filters[]=geometry/scalewidth=1170

*/ ?>
