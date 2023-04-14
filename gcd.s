#int gcd(long x, long y)
#{
#	if (x == 0) {
#  		return y;
#  	}
# 	while (y != 0) {
#    	   if (x > y) {
#      		x = x - y;
#          }
#    	   else {
#      		y = y - x;
#    	   }
#  	}
#  	return x;
#}

#### 170401015 CAN KURTTEKIN ####

.data
mesaj0:	.asciiz "**** Iki Pozitif Sayinin En Buyuk Ortak Bolenini Bulma ****\n"
mesaj1: .asciiz "Birinci Pozitif Sayiyi Giriniz (x)  : "
mesaj2: .asciiz "Ikinci Pozitif Sayiyi Giriniz  (y)  : "
mesaj3:	.asciiz "gcd(x,y)			      : "
mesaj4:	.asciiz "Devam Etmek Istermisiniz Evet(e)/Hayir(h): "
mesaj5:	.asciiz "Program Sonlanmistir ...\n"
newline: .asciiz "\n"

x:	.word	0
y:	.word	0
sonuc:	.word	0

.text
.globl main
main:

la $a0, mesaj0
li $v0, 4
syscall                       # mesaj0 yazdırma

loop:
      #lw $t1, x              # t1 = x
      #lw $t2, y              # t2 = y
      #lw $t3, sonuc          # t3 = sonuc

      la $a0, newline
      li $v0, 4
      syscall
      la $a0, mesaj1          # load mesaj1 address into $a0
      li $v0, 4               # print
      syscall

      li $v0, 5
      syscall
      add $t1, $v0, $zero     # store x in $t1

      la $a0, mesaj2          # load mesaj2 address into $a0
      li $v0, 4               # print
      syscall

      li $v0, 5
      syscall
      add $t2, $v0, $zero     # store y in $t2
      move $t8, $zero
      beq $t8, $zero, gcd
      li $t3, 0

gcd:
      add $t3, $t2, $zero                       # sonuc = y
      beqz $t1, print                           # if (x == 0) print t3(y)
      li	$t3, 0                                # yukarıda branch a girmediği için t3 ü geri sıfırlıyoruz
      while:
            add $t3, $t1, $zero                 # sonuc = x
            beqz $t2, print                     # if y == 0 go to print x
            ble $t1, $t2, calc                  # x <= y  ise dddd e git
            sub $t1, $t1, $t2                   # x = x - y
            bnez $t2, while                     # if y != 0 keep while loop else go to print
            calc:
                  sub $t2, $t2, $t1             # y = y - x
                  bnez $t2, while               # if y != 0 keep while loop else go to print
                  add $t3, $t1, $zero           # sonuc = x

print:                  # sonucu print eden kısım
      li   $v0, 4
      la   $a0, mesaj3
      syscall
      li   $v0, 1
      move $a0, $t3
      syscall
      la $a0, newline
      li $v0, 4
      syscall

user:                   # kullanıcıya tamam mı devam mı soruyoruz.
      li $v0, 4
      la $a0, mesaj4
      syscall
      li $v0, 12        # kullanıcıdan karakter girmesini istiyoruz.
      syscall
      beq $v0, 'e', loop
      beq $v0, 'h', exit
      la $a0, newline
      li $v0, 4
      syscall
      j user            # eğer 'e' veya 'h' dışında bir tuşlama yapıldıysa tekrar sormak için user a dönüyoruz.

exit:
      la $a0, newline
      li $v0, 4
      syscall
      la $a0, mesaj5
      li $v0, 4
      syscall
      li $v0, 10
      syscall
