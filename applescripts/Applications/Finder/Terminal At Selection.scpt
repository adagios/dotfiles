FasdUAS 1.101.10   ��   ��    k             l     ��  ��    C = � Copyright 2005, Red Sweater Software. All Rights Reserved.     � 	 	 z   �   C o p y r i g h t   2 0 0 5 ,   R e d   S w e a t e r   S o f t w a r e .   A l l   R i g h t s   R e s e r v e d .   
  
 l     ��  ��    R L Permission to copy granted for personal use only. All copies of this script     �   �   P e r m i s s i o n   t o   c o p y   g r a n t e d   f o r   p e r s o n a l   u s e   o n l y .   A l l   c o p i e s   o f   t h i s   s c r i p t      l     ��  ��    T N must retain this copyright information and all lines of comments below, up to     �   �   m u s t   r e t a i n   t h i s   c o p y r i g h t   i n f o r m a t i o n   a n d   a l l   l i n e s   o f   c o m m e n t s   b e l o w ,   u p   t o      l     ��  ��    H B and including the line indicating "End of Red Sweater Comments".      �   �   a n d   i n c l u d i n g   t h e   l i n e   i n d i c a t i n g   " E n d   o f   R e d   S w e a t e r   C o m m e n t s " .        l     ��������  ��  ��        l     ��  ��    S M Any commercial distribution of this code must be licensed from the Copyright     �   �   A n y   c o m m e r c i a l   d i s t r i b u t i o n   o f   t h i s   c o d e   m u s t   b e   l i c e n s e d   f r o m   t h e   C o p y r i g h t     !   l     �� " #��   " #  owner, Red Sweater Software.    # � $ $ :   o w n e r ,   R e d   S w e a t e r   S o f t w a r e . !  % & % l     ��������  ��  ��   &  ' ( ' l     �� ) *��   ) Q K This script facilitates the easy opening of a Terminal window prepared to     * � + + �   T h i s   s c r i p t   f a c i l i t a t e s   t h e   e a s y   o p e n i n g   o f   a   T e r m i n a l   w i n d o w   p r e p a r e d   t o   (  , - , l     �� . /��   . W Q perform command-line operations at the directory currently selected or navigated    / � 0 0 �   p e r f o r m   c o m m a n d - l i n e   o p e r a t i o n s   a t   t h e   d i r e c t o r y   c u r r e n t l y   s e l e c t e d   o r   n a v i g a t e d -  1 2 1 l     �� 3 4��   3   to in the Finder.    4 � 5 5 $   t o   i n   t h e   F i n d e r . 2  6 7 6 l     ��������  ��  ��   7  8 9 8 l     �� : ;��   :   Version 1.1.1     ; � < <    V e r s i o n   1 . 1 . 1   9  = > = l     �� ? @��   ? _ Y		- Disable iTerm support until I can get it to load on machines without iTerm installed.    @ � A A � 	 	 -   D i s a b l e   i T e r m   s u p p o r t   u n t i l   I   c a n   g e t   i t   t o   l o a d   o n   m a c h i n e s   w i t h o u t   i T e r m   i n s t a l l e d . >  B C B l     ��������  ��  ��   C  D E D l     �� F G��   F   Version 1.1    G � H H    V e r s i o n   1 . 1 E  I J I l     �� K L��   K b \		- Be sure to use the quoted form of the target folder in case there are funky chars in it.    L � M M � 	 	 -   B e   s u r e   t o   u s e   t h e   q u o t e d   f o r m   o f   t h e   t a r g e t   f o l d e r   i n   c a s e   t h e r e   a r e   f u n k y   c h a r s   i n   i t . J  N O N l     �� P Q��   P U O		- Updated with modifications by Jan Lehnardt <jan@prima.de> to support iTerm.    Q � R R � 	 	 -   U p d a t e d   w i t h   m o d i f i c a t i o n s   b y   J a n   L e h n a r d t   < j a n @ p r i m a . d e >   t o   s u p p o r t   i T e r m . O  S T S l     �� U V��   U 4 .			 iTerm can be found on http://iterm.sf.net/    V � W W \ 	 	 	   i T e r m   c a n   b e   f o u n d   o n   h t t p : / / i t e r m . s f . n e t / T  X Y X l     ��������  ��  ��   Y  Z [ Z l     �� \ ]��   \ ; 5 Version 1.0 - worked with Terminal application only.    ] � ^ ^ j   V e r s i o n   1 . 0   -   w o r k e d   w i t h   T e r m i n a l   a p p l i c a t i o n   o n l y . [  _ ` _ l     ��������  ��  ��   `  a b a l     �� c d��   c "  End of Red Sweater Comments    d � e e 8   E n d   o f   R e d   S w e a t e r   C o m m e n t s b  f g f l     ��������  ��  ��   g  h i h l     �� j k��   j   Advice from Jan:    k � l l "   A d v i c e   f r o m   J a n : i  m n m l     �� o p��   o J D To customise this script change the value of terminalApplication to    p � q q �   T o   c u s t o m i s e   t h i s   s c r i p t   c h a n g e   t h e   v a l u e   o f   t e r m i n a l A p p l i c a t i o n   t o n  r s r l     �� t u��   t _ Y either "Terminal", to use this script with the default Terminal.app that ships with OS X    u � v v �   e i t h e r   " T e r m i n a l " ,   t o   u s e   t h i s   s c r i p t   w i t h   t h e   d e f a u l t   T e r m i n a l . a p p   t h a t   s h i p s   w i t h   O S   X s  w x w l     �� y z��   y U O or to "iTerm", to use this script with the iTerm.app from http://iTerm.sf.net/    z � { { �   o r   t o   " i T e r m " ,   t o   u s e   t h i s   s c r i p t   w i t h   t h e   i T e r m . a p p   f r o m   h t t p : / / i T e r m . s f . n e t / x  | } | l     �� ~ ��   ~ ^ X    If you use iTerm, you can set the iTermSessionName to the session of your preference     � � � �         I f   y o u   u s e   i T e r m ,   y o u   c a n   s e t   t h e   i T e r m S e s s i o n N a m e   t o   t h e   s e s s i o n   o f   y o u r   p r e f e r e n c e }  � � � l     ��������  ��  ��   �  � � � l     ����� � r      � � � m      � � � � � 
 i T e r m � o      ���� *0 terminalapplication terminalApplication��  ��   �  � � � l    ����� � r     � � � m     � � � � �  D e f a u l t � o      ���� $0 itermsessionname iTermSessionName��  ��   �  � � � l     ��������  ��  ��   �  � � � l    ����� � r     � � � m    	 � � � � �   � o      ���� 0 targetfolder targetFolder��  ��   �  � � � l     ��������  ��  ��   �  � � � l   � ����� � O    � � � � k    � � �  � � � r     � � � l    ����� � c     � � � 1    ��
�� 
sele � m    ��
�� 
list��  ��   � o      ���� 0 myselection mySelection �  � � � l   ��������  ��  ��   �  � � � l   �� � ���   � X R If there is a single item selected, assume the user wants something close to that    � � � � �   I f   t h e r e   i s   a   s i n g l e   i t e m   s e l e c t e d ,   a s s u m e   t h e   u s e r   w a n t s   s o m e t h i n g   c l o s e   t o   t h a t �  � � � Z    { � ����� � l    ����� � =    � � � l    ����� � I   �� ���
�� .corecnte****       **** � o    ���� 0 myselection mySelection��  ��  ��   � m    ���� ��  ��   � k   " w � �  � � � r   " ( � � � n   " & � � � 4  # &�� �
�� 
cobj � m   $ %����  � o   " #���� 0 myselection mySelection � o      ���� "0 targetcandidate targetCandidate �  � � � l  ) )��������  ��  ��   �  � � � l  ) )�� � ���   � W Q If the user has selected a folder or disk icon, then make that the target folder    � � � � �   I f   t h e   u s e r   h a s   s e l e c t e d   a   f o l d e r   o r   d i s k   i c o n ,   t h e n   m a k e   t h a t   t h e   t a r g e t   f o l d e r �  � � � Z   ) u � ��� � � G   ) : � � � =  ) . � � � l  ) , ����� � n   ) , � � � 1   * ,��
�� 
pcls � o   ) *���� "0 targetcandidate targetCandidate��  ��   � m   , -��
�� 
cdis � =  1 6 � � � l  1 4 ����� � n   1 4 � � � 1   2 4��
�� 
pcls � o   1 2���� "0 targetcandidate targetCandidate��  ��   � m   4 5��
�� 
cfol � r   = H � � � n   = F � � � 1   B F��
�� 
psxp � l  = B ����� � c   = B � � � o   = >���� "0 targetcandidate targetCandidate � m   > A��
�� 
alis��  ��   � o      ���� 0 targetfolder targetFolder��   � k   K u � �  � � � l  K K�� � ���   � N H Special case Network, since POSIX path doesn't work as expected with it    � � � � �   S p e c i a l   c a s e   N e t w o r k ,   s i n c e   P O S I X   p a t h   d o e s n ' t   w o r k   a s   e x p e c t e d   w i t h   i t �  ��� � Z   K u � ��� � � l  K T ����� � =  K T � � � n   K P � � � 1   L P��
�� 
pURL � o   K L���� "0 targetcandidate targetCandidate � m   P S � � � � � 0 f i l e : / / l o c a l h o s t / N e t w o r k��  ��   � r   W e � � � n   W c � � � 1   _ c��
�� 
psxp � 4   W _�� �
�� 
alis � m   [ ^ � � � � �  M a c i n t o s h   H D : � o      ���� 0 targetfolder targetFolder��   � k   h u � �  � � � l  h h�� � ���   � \ V If the user has selected anything else, then make the containing folder the selection    � � � � �   I f   t h e   u s e r   h a s   s e l e c t e d   a n y t h i n g   e l s e ,   t h e n   m a k e   t h e   c o n t a i n i n g   f o l d e r   t h e   s e l e c t i o n �  ��� � r   h u �  � n   h s 1   o s��
�� 
psxp l  h o���� c   h o n  h k m   i k��
�� 
cfol o   h i���� "0 targetcandidate targetCandidate m   k n��
�� 
alis��  ��    o      ���� 0 targetfolder targetFolder��  ��   � �� l  v v��~�}�  �~  �}  ��  ��  ��   � 	
	 l  | |�|�{�z�|  �{  �z  
  l  | |�y�y   M G Otherwise, resort to the folder corresponding to the front-most window    � �   O t h e r w i s e ,   r e s o r t   t o   t h e   f o l d e r   c o r r e s p o n d i n g   t o   t h e   f r o n t - m o s t   w i n d o w  Z   | ��x�w l  | ��v�u =  | � o   | }�t�t 0 targetfolder targetFolder m   } � �  �v  �u   Q   � � r   � � n   � � 1   � ��s
�s 
psxp l  � � �r�q  c   � �!"! n  � �#$# m   � ��p
�p 
cfol$ 4   � ��o%
�o 
cwin% m   � ��n�n " m   � ��m
�m 
alis�r  �q   o      �l�l 0 targetfolder targetFolder R      �k�j�i
�k .ascrerr ****      � ****�j  �i   r   � �&'& m   � �(( �))  ' o      �h�h 0 targetfolder targetFolder�x  �w   *+* l  � ��g�f�e�g  �f  �e  + ,-, l  � ��d./�d  . 3 - If we still have nothing, assume the Desktop   / �00 Z   I f   w e   s t i l l   h a v e   n o t h i n g ,   a s s u m e   t h e   D e s k t o p- 1�c1 Z   � �23�b�a2 l  � �4�`�_4 =  � �565 o   � ��^�^ 0 targetfolder targetFolder6 m   � �77 �88  �`  �_  3 r   � �9:9 n   � �;<; 1   � ��]
�] 
psxp< l  � �=�\�[= I  � ��Z>?
�Z .earsffdralis        afdr> m   � ��Y
�Y afdmdesk? �X@�W
�X 
rtyp@ m   � ��V
�V 
alis�W  �\  �[  : o      �U�U 0 targetfolder targetFolder�b  �a  �c   � m    AA�                                                                                  MACS  alis    r  Macintosh HD               �ԥ�H+     j
Finder.app                                                       ��ǵ�        ����  	                CoreServices    �ԗ�      ǵ�       j   &   %  3Macintosh HD:System:Library:CoreServices:Finder.app    
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��  ��  ��   � BCB l     �T�S�R�T  �S  �R  C DED l     �QFG�Q  F . ( Finally, open a terminal with this path   G �HH P   F i n a l l y ,   o p e n   a   t e r m i n a l   w i t h   t h i s   p a t hE I�PI l  �yJ�O�NJ Q   �yKLMK k   �jNN OPO l  � ��MQR�M  Q ' ! Go with the default Terminal.app   R �SS B   G o   w i t h   t h e   d e f a u l t   T e r m i n a l . a p pP T�LT Z   �jUVWXU l  � �Y�K�JY =  � �Z[Z o   � ��I�I *0 terminalapplication terminalApplication[ m   � �\\ �]]  T e r m i n a l�K  �J  V k   � �^^ _`_ O   � �aba k   � �cc ded I  � ��H�G�F
�H .miscactvnull��� ��� null�G  �F  e f�Ef I  � ��Dg�C
�D .coredoscnull��� ��� ctxtg b   � �hih m   � �jj �kk  c d  i n   � �lml 1   � ��B
�B 
strqm o   � ��A�A 0 targetfolder targetFolder�C  �E  b m   � �nn�                                                                                      @ alis    j  Macintosh HD               �ԥ�H+     rTerminal.app                                                     Y��<��        ����  	                	Utilities     �ԗ�      �<��       r   q  0Macintosh HD:Applications:Utilities:Terminal.app    T e r m i n a l . a p p    M a c i n t o s h   H D  #Applications/Utilities/Terminal.app   / ��  ` opo l  � ��@�?�>�@  �?  �>  p qrq l   � ��=st�=  s � � Until I can figure out how to make this open nicely on machines without iTerm installed
	I am just going to disable the iTerm support. Users who want to enable it can uncomment this block
   t �uuz   U n t i l   I   c a n   f i g u r e   o u t   h o w   t o   m a k e   t h i s   o p e n   n i c e l y   o n   m a c h i n e s   w i t h o u t   i T e r m   i n s t a l l e d 
 	 I   a m   j u s t   g o i n g   t o   d i s a b l e   t h e   i T e r m   s u p p o r t .   U s e r s   w h o   w a n t   t o   e n a b l e   i t   c a n   u n c o m m e n t   t h i s   b l o c k 
r vwv l  � ��<�;�:�<  �;  �:  w x�9x l  � ��8yz�8  y / ) Wooho, we've got iTerm and we want iIerm   z �{{ R   W o o h o ,   w e ' v e   g o t   i T e r m   a n d   w e   w a n t   i I e r m�9  W |}| l  � �~�7�6~ =  � �� o   � ��5�5 *0 terminalapplication terminalApplication� m   � ��� ��� 
 i T e r m�7  �6  } ��4� O   �`��� k  _�� ��� I 	�3�2�1
�3 .miscactvnull��� ��� null�2  �1  � ��� l 

�0���0  � / ) See, if there is an open iTerm window...   � ��� R   S e e ,   i f   t h e r e   i s   a n   o p e n   i T e r m   w i n d o w . . .� ��� Q  
.���� r  ��� l ��/�.� 4 �-�
�- 
Ptrm� m  �,�, �/  �.  � o      �+�+ 
0 myterm  � R      �*�)�(
�* .ascrerr ****      � ****�)  �(  � k  .�� ��� l �'���'  � #  ...There's not, we open one	   � ��� :   . . . T h e r e ' s   n o t ,   w e   o p e n   o n e 	� ��&� r  .��� l *��%�$� I *�#�"�
�# .corecrel****      � null�"  � �!�� 
�! 
kocl� m  #&�
� 
Ptrm�   �%  �$  � o      �� 
0 myterm  �&  � ��� l //����  �  �  � ��� O  /]��� k  5\�� ��� l 55����  � . ( Open a new Default session in a new tab   � ��� P   O p e n   a   n e w   D e f a u l t   s e s s i o n   i n   a   n e w   t a b� ��� I 5>���
� .ITRMLNCHPssn       obj �  � ���
� 
Pssn� o  9:�� $0 itermsessionname iTermSessionName�  � ��� O  ?Z��� I HY���
� .ITRMWrtenull���    obj �  � ���
� 
iTxt� b  LU��� m  LO�� ���  c d  � n  OT��� 1  PT�
� 
strq� o  OP�� 0 targetfolder targetFolder�  � l ?E���� 4 ?E��
� 
Pssn� m  CD�����  �  � ��
� l [[�	���	  �  �  �
  � o  /2�� 
0 myterm  � ��� l ^^����  �  �  �  � m   ����                                                                                  ITRM  alis    H  Macintosh HD               �ԥ�H+     q	iTerm.app                                                      ��4ʎ��        ����  	                Applications    �ԗ�      ʎ��       q  #Macintosh HD:Applications:iTerm.app    	 i T e r m . a p p    M a c i n t o s h   H D  Applications/iTerm.app  / ��  �4  X I cj��� 
� .sysodlogaskr        TEXT� m  cf�� ��� d T h e   s e l e c t e d   T e r m i n a l   p r o g r a m   i s n ' t   y e t   s u p p o r t e d .�   �L  L R      ������
�� .ascrerr ****      � ****��  ��  M I ry�����
�� .sysodlogaskr        TEXT� m  ru�� ��� 0 S o r r y ,   I   c o u l d n ' t   d o   i t .��  �O  �N  �P       ������  � ��
�� .aevtoappnull  �   � ****� �����������
�� .aevtoappnull  �   � ****� k    y��  ���  ���  ���  ��� I����  ��  ��  �  � 3 ��� ��� ���A�������������������������� � �������(7������\n��j����������������������������� *0 terminalapplication terminalApplication�� $0 itermsessionname iTermSessionName�� 0 targetfolder targetFolder
�� 
sele
�� 
list�� 0 myselection mySelection
�� .corecnte****       ****
�� 
cobj�� "0 targetcandidate targetCandidate
�� 
pcls
�� 
cdis
�� 
cfol
�� 
bool
�� 
alis
�� 
psxp
�� 
pURL
�� 
cwin��  ��  
�� afdmdesk
�� 
rtyp
�� .earsffdralis        afdr
�� .miscactvnull��� ��� null
�� 
strq
�� .coredoscnull��� ��� ctxt
�� 
Ptrm�� 
0 myterm  
�� 
kocl
�� .corecrel****      � null
�� 
Pssn
�� .ITRMLNCHPssn       obj 
�� 
iTxt
�� .ITRMWrtenull���    obj 
�� .sysodlogaskr        TEXT��z�E�O�E�O�E�O� �*�,�&E�O�j 
k  Z��k/E�O��,� 
 ��,� a & �a &a ,E�Y ,�a ,a   )a a /a ,E�Y ��,a &a ,E�OPY hO�a   ' *a k/�,a &a ,E�W X  a E�Y hO�a   a a a l a ,E�Y hUO ��a   !a   *j !Oa "�a #,%j $UOPY v�a %  ga & ]*j !O *a 'k/E` (W X  *a )a 'l *E` (O_ ( )*a +�l ,O*a +i/ *a -a .�a #,%l /UOPUOPUY 	a 0j 1W X  a 2j 1ascr  ��ޭ