# Bookshelf IOS app
Elan Goens\
3A1\
Lector: Steven Van Impe\
Gebruikte technologie: SwiftUI

## Inloggegevens
- username: student@hogent.be
- password: P@ssword1111

Of maak zelf een account aan!

## Samenvatting

Op de Bookshelf app kan een gebruiker een lijst van boeken raadplegen. Deze boeken kunnen worden aangeduid als favoriet, en gebruikers kunnen ook recensies achterlaten 
die dan door andere gebruikers kunnen worden gezien.\
De API die wordt gebruikt kunt u hier vinden: https://bookshelfapiwebiv.azurewebsites.net/swagger/index.html#/ \
Deze API staat op de free tier van Azure. Hierdoor kan het zijn dat de eerste keer dat u de app opstart, het een tiental seconden kan duren voor de eerste request volbracht is.


## Views

### 1. Inloggen

Op deze pagina kan een bestaande gebruiker zijn/haar email en wachtwoord ingeven om in te loggen. Er wordt een foutmelding gegeven wanneer de gebruiker niet bestaat of wanneer de combinatie van email en wachtwoord niet klopt. Na het klikken op de inlogknop wordt de gebruiker omgeleid naar de homepagina.

![alt text](https://user-images.githubusercontent.com/60932656/148674873-35815f46-1eae-4c26-a826-60e67e1af3e8.png)

### 2. Registreren

Hier kan een niewe gebruiker zijn/haar voornaam, familienaam, email en wachtwoord ingeven om te registreren. Er worden verschillende foutmeldingen gegeven als bijvoorbeeld de wachtwoorden niet overeen komen, of als er geen geldig email-adres werd ingevoerd.

![alt text](https://user-images.githubusercontent.com/60932656/148674917-64151bc4-2fed-4181-8669-145e46b89db4.png)

### 3. Home

Na het inloggen komt een gebruiker op de homepagina terecht. Hier komen voornamelijk updated over de app en eventueel nieuwe boeken.

![alt text](https://user-images.githubusercontent.com/60932656/148675253-c5d69cee-1ea7-4e52-bc46-c7d0553742d0.png)

### 4. Catalogus

Op de cataloguspagina kunnen de boeken in de bib geraadpleegd worden. Er kan hier ook gefilterd worden op titel. Wanneer een gebruiker een boek selecteert, wordt er doorverwezen naar de details van dat specifieke boek, zoals de auteur en een omschrijving. Hier kan je ook een recensie achterlaten over dat boek door het een rating te geven en eventueel een kleine tekst te schrijven. Een toegevoegde recensie verschijnt direct onderaan de pagina.

![alt text](https://user-images.githubusercontent.com/60932656/148675305-fd8cb594-331b-4623-b84e-c03b9b4ef73d.png)
![alt text](https://user-images.githubusercontent.com/60932656/148675390-f3a6aae8-dda0-4dfb-8f05-e8e5b19f8fb1.png)
![alt text](https://user-images.githubusercontent.com/60932656/148675434-0c36f84f-88f1-4b4e-b317-e6ca585c1f46.png)

### 5. Profiel

Hier krijg je een overzicht te zien van uw gegevens, alsook een lijst van de boeken die u heeft toegevoegd aan uw favorieten. Hier kunt u deze boeken ook uit uw favorieten verwijderen.

![alt text](https://user-images.githubusercontent.com/60932656/148675271-ee9bfc6b-2df2-40b0-8c29-05874ce5d6a6.png)



