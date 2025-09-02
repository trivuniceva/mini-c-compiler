# Programski prevodioci – Kompajler za Mini C

Ovaj repozitorijum sadrži vežbe iz predmeta Programski prevodioci, a njihov cilj je razvoj kompletnog kompajlera za programski jezik Mini C. Projekat je podeljen u nekoliko faza koje obuhvataju ključne delove procesa prevođenja programskog jezika.


## Faze kompajlera

- **Leksička analiza (Skener):**  
  Prva faza prepoznavanja i razbijanja ulaznog teksta na tokene. Za ovu fazu korišćen je alat **Flex**, a tokeni su definisani pomoću regularnih izraza.
- **Sintaksna analiza (Parser):**  
  U ovoj fazi proverava se da li su tokeni u pravilnom redosledu, u skladu sa gramatikom jezika definisanom u **BNF notaciji**. Za implementaciju je korišćen alat **Bison**.

- **Semantička analiza:**  
  Provera semantičkih grešaka (npr. nekompatibilnost tipova, korišćenje nedeklarisanih promenljivih) vrši se pomoću **tabele simbola**.

- **Generisanje koda:**  
  Finalna faza u kojoj se Mini C kod prevodi u ekvivalentan asemblerski kod za hipotetsku mašinu. Generisani kod se izvršava u **Hipsim simulatoru**.

---

## Korišćeni alati

- **Flex** – generator leksičkog analizatora
- **Bison** – generator sintaksnog analizatora (parsera)
- **GCC** – GNU C kompajler
- **GNU make** – alat za automatizaciju procesa kompajliranja.
- **Hipsim** – simulator hipotetske mašine, namenjen za izvršavanje generisanog asemblerskog koda.

---

## Kompajliranje i pokretanje

Da biste pokrenuli program, dovoljno je koristiti `make` komandu.

```sh
# Kompajliranje projekta
make

# Pokretanje kompajlera sa ulazom iz datoteke
./micko < ulaz.mc

```

Ukoliko je prevođenje uspešno, biće generisana datoteka output.asm. Za izvršavanje generisanog koda u simulatoru, koristite:

```sh
# Izvršavanje asemblerskog koda
./hipsim -r < output.asm
```


Detaljnije informacije o svakoj fazi, kao i zadacima, mogu se pronaći u pratećim PDF dokumentima.