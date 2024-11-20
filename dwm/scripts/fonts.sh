#!/bin/bash

export SUDO_ASKPASS="/home/adi/.config/dwm/scripts/dmenu_askpass.sh"

font="$(echo -e '1. Victor\n2. JetBrains\n3. Iosevka\n4. Pragmasevka\n5. Blex\n6. IBM Plex\n7. Lekton\n8. Nanum Gothic Coding\n9. Ubuntu\n10. Fira Code\n11. Sarasa Gothic\n12. Recursive Mono\n13. Inconsolata\n14. Share Tech\n15. Reddit Mono\n16. Monoid\n17. Fantasque\n18. Input\n19. Monoisome\n20. Martian\n21. Caskaydia Cove' | dmenu -p 'Choose Font' -l 10 | cut -d. -f1)"

sudo -A ~/repo/style/font $font
