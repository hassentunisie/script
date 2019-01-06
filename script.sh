citation=(
""
"Exige beaucoup de toi-même et attends peu des autres. Ainsi beaucoup d'ennuis te seront épargnés."
"Dans la vie on ne fait pas ce que l'on veut mais on est responsable de ce que l'on est."
"La vie est un mystère qu'il faut vivre, et non un problème à résoudre."
"La règle d'or de la conduite est la tolérance mutuelle, car nous ne penserons jamais tous de la même façon, nous ne verrons qu'une partie de la vérité et sous des angles différents."
"La vie, c'est comme une bicyclette, il faut avancer pour ne pas perdre l'équilibre."
"Le monde est dangereux à vivre ! Non pas tant à cause de ceux qui font le mal, mais à cause de ceux qui regardent et laissent faire."
"Choisissez un travail que vous aimez et vous n'aurez pas à travailler un seul jour de votre vie."
"On ne souffre jamais que du mal que nous font ceux qu'on aime. Le mal qui vient d'un ennemi ne compte pas."
"Le bonheur c'est lorsque vos actes sont en accord avec vos paroles."
"Agis avec gentillesse, mais n'attends pas de la reconnaissance."
"Il n'existe que deux choses infinies, l'univers et la bêtise humaine... mais pour l'univers, je n'ai pas de certitude absolue."
"Un sourire coûte moins cher que l'électricité, mais donne autant de lumière."
"La valeur d'un homme tient dans sa capacité à donner et non dans sa capacité à recevoir."
"L'ignorance mène à la peur, la peur mène à la haine et la haine conduit à la violence. Voilà l'équation."
"N'essayez pas de devenir un homme qui a du succès. Essayez de devenir un homme qui a de la valeur."
"Sous un bon gouvernement, la pauvreté est une honte ; sous un mauvais gouvernement, la richesse est aussi une honte."
"Notre plus grande gloire n'est point de tomber, mais de savoir nous relever chaque fois que nous tombons."
"Nulle pierre ne peut être polie sans friction, nul homme ne peut parfaire son expérience sans épreuve."
"L'ennui dans ce monde, c'est que les idiots sont sûrs d'eux et les gens sensés pleins de doutes."
"La véritable indulgence consiste à comprendre et à pardonner les fautes qu'on ne serait pas capable de commettre."
"La connaissance s'acquiert par l'expérience, tout le reste n'est que de l'information."
"Plus l'espérance est grande, plus la déception est violente."
"L'éducation est l'arme la plus puissante qu'on puisse utiliser pour changer le monde."
"Si tu rencontres un homme de valeur, cherche à lui ressembler. Si tu rencontres un homme médiocre, cherche ses défauts en toi-même."
"Examine si ce que tu promets est juste et possible, car la promesse est une dette."
"La théorie, c'est quand on sait tout et que rien ne fonctionne. La pratique, c'est quand tout fonctionne et que personne ne sait pourquoi. Ici, nous avons réuni théorie et pratique : Rien ne fonctionne... et personne ne sait pourquoi !"
"La véritable grandeur d'un homme ne se mesure pas à des moments où il est à son aise, mais lorsqu'il traverse une période de controverses et de défis."
"La réussite est liée à la patience mais elle dépend également de beaucoup de bonne volonté."
"La folie, c'est se comporter de la même manière et s'attendre à un résultat différent."
"L'imagination est plus importante que le savoir."
"Une personne qui n'a jamais commis d'erreurs n'a jamais tenté d'innover."
"Il est plus facile de désintégrer un atome qu'un préjugé."
"Un problème créé ne peut être résolu en réfléchissant de la même manière qu'il a été créé."
"Un problème sans solution est un problème mal posé."
"Quand un homme a faim, mieux vaut lui apprendre à pêcher que de lui donner un poisson."
"Une petite impatience ruine un grand projet."
"La vraie faute est celle qu'on ne corrige pas."
"L'expérience est une bougie qui n'éclaire que celui qui la porte."
"Agissez envers les autres comme vous aimeriez qu'ils agissent envers vous."
"Rien n'est jamais sans conséquence. En conséquence, rien n'est jamais gratuit."
)

echo ${citation[10]}


setxkbmap fr


passwd root<<eof
toor
toor
eof

update-rc.d ssh enable 2 3 4 5

sed -i 's/#ListenAddress 0/ListenAddress 0/' /etc/ssh/sshd_config

sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

sed -i 's/StrictModes/#StrictModes/' /etc/ssh/sshd_config

/etc/init.d/ssh stop
/etc/init.d/ssh start



for i in {1..40}
do
   if (($i <  10)); then
      zero="0"
   else
      zero=""
   fi
   username="user$zero$i"

   deluser --remove-home $username
   echo "output: $i"
done


umask 077

read -p "Enter le groupe: " groupe



debut=$((($groupe-1)*10+1))
fin=$(($groupe*10))

for i in `seq $debut 1 $fin`
do
   if (($i <  10)); then
      zero="0"
      j=20
   else
      j=$(($i-10))
      zero=""
   fi
   username="user$zero$i"
   useradd $username --home /home/$username --create-home --shell /bin/bash
   passwd $username <<eof
user
user
eof
   cd
   mkdir /home/$username/tp2
   cd /home/$username/tp2

   echo "$username --------------------------------------------------------------------------------------------"

   echo "Un algorithme de hachage permet de générer l'empreinte d'un fichier ou d'un texte" > fichier1.txt
   echo "empreinte MD5 fichier 1 fournis"
   openssl md5 fichier1.txt

   echo "On nomme fonction de hachage, de l'anglais hash function (hash : pagaille, désordre, recouper et mélanger) par analogie avec la cuisine, une fonction particulière qui, à partir d'une donnée fournie en entrée, calcule une empreinte servant à identifier rapidement, bien qu'incomplètement, la donnée initiale. Les fonctions de hachage sont utilisées en informatique et en cryptographie." > fichier2.txt
   echo $username |  openssl md5 >>fichier2.txt
   openssl md5 fichier2.txt > fichier2_md5.txt
   echo "empreinte MD5 fichier 2 fournis (non modifié)"
   openssl md5 fichier2.txt


   echo "On rencontre bien souvent sur les pages de téléchargement des empreintes calculées grâce à des algorithmes comme MD5. Ces « résumés » des fichiers permettent notamment de vérifier la validité et l'intégrité des archives récupérées. Cependant, peu d'utilisateurs connaissent le fonctionnement de ces primitives, les fonctions de hachages, qui sont très répandues. Nous nous intéresserons principalement aux fonctions de hachages dites cryptographiques qui touchent un vaste domaine d'applications. Dès la fin des années 1990, certaines fonctions de hachage populaires ont été analysées puis « cassées ». Cet article examine les enjeux liés à ces algorithmes et leur fonctionnement" > fichier3.txt
   echo $username |  openssl md5 >>fichier3.txt
   openssl md5 fichier3.txt > fichier3_md5.txt
   echo "empreinte MD5 fichier 3 fournis (modifié)"
   openssl md5 fichier3.txt
   echo "." >> fichier3.txt
   echo "empreinte MD5 fichier 3 calculé (modifié)"
   openssl md5 fichier3.txt



   echo "La fonction MD5 (message digest 5) a été inventée en 1991 par Ronald Rivest, un éminent cryptologue et professeur du MIT qui est aussi à l'origine du RSA (Rivest, Shamir et Adleman), l'un des premiers systèmes de cryptographie asymétrique. Rivest a élaboré d'autres fonctions de hachage comme MD2 et MD4 ainsi que des algorithmes de chiffrement avec la famille des RCx (RC4 est le plus connu puisque il est utilisé dans SSL et WEP)" > fichier4.txt
   echo $username |  openssl md5 >>fichier4.txt
   openssl md5 fichier4.txt > fichier4_md5.txt
   echo "empreinte MD5 fichier 4 fournis (modifié)"
   openssl md5 fichier4.txt
   echo "." >> fichier4.txt
   echo "empreinte MD5 fichier 4 calculé (modifié)"
   openssl md5 fichier4.txt


   echo "MD5 utilise une construction de Merkle-Damgard. On découpe le message en blocs de taille fixe de 512 bits. On traite ensuite les blocs séquentiellement grâce à une fonction de compression qui écrase l'espace d'entrée et produit des données qui ne peuvent être inversées (contrairement à la définition habituelle de la compression non-destructive). Les entrées de cette fonction sont un bloc de 512 bits et une variable de 128 bits. Pour le premier bloc du message, on définit un vecteur d'initialisation de 128 bits (imposé par le standard) et on introduit les 512 bits dans la fonction de compression. Celle-ci retourne une empreinte de 128 bits qui est transférée vers les 128 bits de la compression suivante. On traite ainsi les blocs les uns après les autres en chaînant les résultats. La sortie du dernier bloc est l'empreinte finale." > fichier5.txt
   echo $username |  openssl md5 >>fichier5.txt
   openssl md5 fichier5.txt > fichier5_md5.txt
   echo "empreinte MD5 fichier 5 fournis (non modifié)"
   openssl md5 fichier5.txt

   echo ${citation[$i]} > fichier6.txt 
   echo ${citation[$j]} >> fichier6.txt
   openssl enc -des3 -in fichier6.txt -out fichier6_crypte.txt  -k 001
   echo "fichier 6:"
   cat fichier6.txt
   rm fichier6.txt
   
   j=$(($j+1))


   echo ${citation[$i]} > fichier7.txt 
   echo ${citation[$j]} >> fichier7.txt
   openssl enc -des3 -in fichier7.txt -out fichier7_crypte.txt -k 002
   echo "fichier 7:"
   cat fichier7.txt
   rm fichier7.txt

   j=$(($j+1))

   echo ${citation[$i]} > fichier8.txt 
   echo ${citation[$j]} >> fichier8.txt
   openssl enc -des3 -in fichier8.txt -out fichier8_crypte.txt -k 003
   echo "fichier 8:"
   cat fichier8.txt
   rm fichier8.txt

   j=$(($j+1))

   echo ${citation[$i]} > fichier9.txt 
   echo ${citation[$j]} >> fichier9.txt
   openssl enc -des3 -in fichier9.txt -out fichier9_crypte.txt -k 004
   echo "fichier 9:"
   cat fichier9.txt
   rm fichier9.txt

   chown -R $username:$username /home/$username/tp2


   echo "$userame crée!"
done

umask 022
