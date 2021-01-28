fichiers=(
   ""
   "On nomme fonction de hachage, de l'anglais hash function (hash : pagaille, désordre, recouper et mélanger) par analogie avec la cuisine, une fonction particulière qui, à partir d'une donnée fournie en entrée, calcule une empreinte servant à identifier rapidement, bien qu'incomplètement, la donnée initiale. Les fonctions de hachage sont utilisées en informatique et en cryptographie."
   "On rencontre bien souvent sur les pages de téléchargement des empreintes calculées grâce à des algorithmes comme MD5. Ces « résumés » des fichiers permettent notamment de vérifier la validité et l'intégrité des archives récupérées. Cependant, peu d'utilisateurs connaissent le fonctionnement de ces primitives, les fonctions de hachages, qui sont très répandues. Nous nous intéresserons principalement aux fonctions de hachages dites cryptographiques qui touchent un vaste domaine d'applications. Dès la fin des années 1990, certaines fonctions de hachage populaires ont été analysées puis « cassées ». Cet article examine les enjeux liés à ces algorithmes et leur fonctionnement"
   "La fonction MD5 (message digest 5) a été inventée en 1991 par Ronald Rivest, un éminent cryptologue et professeur du MIT qui est aussi à l'origine du RSA (Rivest, Shamir et Adleman), l'un des premiers systèmes de cryptographie asymétrique. Rivest a élaboré d'autres fonctions de hachage comme MD2 et MD4 ainsi que des algorithmes de chiffrement avec la famille des RCx (RC4 est le plus connu puisque il est utilisé dans SSL et WEP)"
   "MD5 utilise une construction de Merkle-Damgard. On découpe le message en blocs de taille fixe de 512 bits. On traite ensuite les blocs séquentiellement grâce à une fonction de compression qui écrase l'espace d'entrée et produit des données qui ne peuvent être inversées (contrairement à la définition habituelle de la compression non-destructive). Les entrées de cette fonction sont un bloc de 512 bits et une variable de 128 bits. Pour le premier bloc du message, on définit un vecteur d'initialisation de 128 bits (imposé par le standard) et on introduit les 512 bits dans la fonction de compression. Celle-ci retourne une empreinte de 128 bits qui est transférée vers les 128 bits de la compression suivante. On traite ainsi les blocs les uns après les autres en chaînant les résultats. La sortie du dernier bloc est l'empreinte finale."
)

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


echo "suppression des utilisateurs..."
for i in {1..40}
do
   if (($i <  10)); then
      zero="0"
   else
      zero=""
   fi
   username="user$zero$i"

   deluser --remove-home $username >& /dev/null
done


umask 377

echo "" > /root/correct.txt


for i in `seq 1 1 40`
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
   echo "$username:user" | chpasswd
   echo "création de l'utilisateur $username..."

   cd
   mkdir /home/$username/tp2
   cd /home/$username/tp2
   echo $username"---------------------------------------------" >> /root/correct.txt
   echo "$username --------------------------------------------------------------------------------------------"
   echo "Vous trouvez ci-dessous les empreintes MD5 des fichiers fichier2.txt, fichier3.txt fichier4.md5 et fichier5.txt" > empreinte_md5_fournis.txt
   echo "Un algorithme de hachage permet de générer l'empreinte d'un fichier ou d'un texte" > fichier1.txt



   echo "génération des fichiers de l'utilisateur..."
   for filei in `seq 2 1 5`
   do
      echo ${fichiers[$filei]} > fichier$filei.txt
      echo $username |  openssl md5 >>fichier$filei.txt
      openssl md5 fichier$filei.txt >> empreinte_md5_fournis.txt
      openssl md5 fichier$filei.txt >> /root/correct.txt
      if (($filei == 3));
      then
         echo "." >> fichier$filei.txt
      fi
      if (($filei == 4));
      then
         echo "." >> fichier$filei.txt
      fi
      openssl md5 fichier$filei.txt >> /root/correct.txt
      echo "" >> /root/correct.txt
   done

   
   j=$(($j+1))
   pw=(
      ""
      "001"
      "002"
      "003"
      "004"
   )
   for files in `seq 6 1 9`
   do
      let r=$files*13+13*$i+100-$i
      cry="_crypte.txt"
      echo $r > fichier$files.txt 
      echo "fichier$files.txt $r"  >> /root/correct.txt
      openssl enc -pbkdf2 -des3 -in fichier$files.txt -out fichier$files$cry -k ${pw[$files-5]}
      rm fichier$files.txt
   done
   chown -R $username:$username /home/$username/*
   chmod 600 /home/$username/tp2/fichier1.txt
   chmod 700 /home/$username/tp2

done

umask 022
