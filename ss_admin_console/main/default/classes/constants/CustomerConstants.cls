public with sharing class CustomerConstants {
    public static final String NAME_API_NAME = 'Name';
    public static final String ACCOUNT_ID_API_NAME = 'AccountId';
    public static final String EMAIL_API_NAME = 'Email';

    public static final String ACCOUNT_API_NAME = 'Account';
    public static final String CONTACT_API_NAME = 'Contact';

    public static Map<String, Account> ACCOUNT_DATA = new Map<String, Account> {
            'Social Software' => new Account(Name = 'Social Software'),
            'Adept Software' => new Account(Name = 'Adept Software'),
            'Boss Software' => new Account(Name = 'Boss Software'),
            'Scope Software' => new Account(Name = 'Scope Software'),
            'Variable Software' => new Account(Name = 'Variable Software'),
            'Cornerstone Software' => new Account(Name = 'Cornerstone Software'),
            'Ascend Software' => new Account(Name = 'Ascend Software'),
            'Consumer Software' => new Account(Name = 'Consumer Software'),
            'Velocity Software' => new Account(Name = 'Velocity Software'),
            'Urge Software' => new Account(Name = 'Urge Software'),
            'Access Software' => new Account(Name = 'Access Software'),
            'Fiber Software' => new Account(Name = 'Fiber Software'),
            'Ideal Software' => new Account(Name = 'Ideal Software'),
            'Marine Software' => new Account(Name = 'Marine Software'),
            'Intellect Software' => new Account(Name = 'Intellect Software'),
            'Softwaregenics' => new Account(Name = 'Softwaregenics'),
            'Point Software' => new Account(Name = 'Point Software'),
            'Vision Software' => new Account(Name = 'Vision Software'),
            'Softserve' => new Account(Name = 'Softserve'),
            'Clever Software' => new Account(Name = 'Clever Software'),
            'Softwareya' => new Account(Name = 'Softwareya'),
            'Measured Software' => new Account(Name = 'Measured Software'),
            'Task Software' => new Account(Name = 'Task Software'),
            'Progress Software' => new Account(Name = 'Progress Software'),
            'Touch Software' => new Account(Name = 'Touch Software'),
            'Up Software' => new Account(Name = 'Up Software'),
            'Mega Software' => new Account(Name = 'Mega Software'),
            'Super Software' => new Account(Name = 'Super Software'),
            'SuperPuper Software' => new Account(Name = 'SuperPuper Software'),
            'SuperNice Software' => new Account(Name = 'SuperNice Software'),
            'Weight Software' => new Account(Name = 'Weight Software'),
            'Wild Software' => new Account(Name = 'Wild Software')
    };

    public static Map<String, Contact> CONTACT_DATA = new Map<String, Contact> {
            'OliviaSmith@testmail.com' => new Contact(LastName = 'Smith', FirstName = 'Olivia', Email = 'OliviaSmith@testmail.com'),
            'EmmaBrown@testmail.com' => new Contact(LastName = 'Brown', FirstName = 'Emma', Email = 'EmmaBrown@testmail.com'),
            'AmeliaWilson@testmail.com' => new Contact(LastName = 'Wilson', FirstName = 'Amelia', Email = 'AmeliaWilson@testmail.com'),
            'AvaThomson@testmail.com' => new Contact(LastName = 'Thomson', FirstName = 'Ava', Email = 'AvaThomson@testmail.com'),
            'SophiaRobertson@testmail.com' => new Contact(LastName = 'Robertson', FirstName = 'Sophia', Email = 'SophiaRobertson@testmail.com'),
            'CharlotteCampbell@testmail.com' => new Contact(LastName = 'Campbell', FirstName = 'Charlotte', Email = 'CharlotteCampbell@testmail.com'),
            'IsabellaStewart@testmail.com' => new Contact(LastName = 'Stewart', FirstName = 'Isabella', Email = 'IsabellaStewart@testmail.com'),
            'MiaAnderson@testmail.com' => new Contact(LastName = 'Anderson', FirstName = 'Mia', Email = 'MiaAnderson@testmail.com'),
            'LunaMacdonald@testmail.com' => new Contact(LastName = 'Macdonald', FirstName = 'Luna', Email = 'LunaMacdonald@testmail.com'),
            'HarperScott@testmail.com' => new Contact(LastName = 'Scott', FirstName = 'Harper', Email = 'HarperScott@testmail.com'),
            'GiannaReid@testmail.com' => new Contact(LastName = 'Reid', FirstName = 'Gianna', Email = 'GiannaReid@testmail.com'),
            'EvelynMurray@testmail.com' => new Contact(LastName = 'Murray', FirstName = 'Evelyn', Email = 'EvelynMurray@testmail.com'),
            'AriaTaylor@testmail.com' => new Contact(LastName = 'Taylor', FirstName = 'Aria', Email = 'AriaTaylor@testmail.com'),
            'EllaClark@testmail.com' => new Contact(LastName = 'Clark', FirstName = 'Ella', Email = 'EllaClark@testmail.com'),
            'EllieMitchell@testmail.com' => new Contact(LastName = 'Mitchell', FirstName = 'Ellie', Email = 'EllieMitchell@testmail.com'),
            'MilaRoss@testmail.com' => new Contact(LastName = 'Ross', FirstName = 'Mila', Email = 'MilaRoss@testmail.com'),
            'CamilaWalker@testmail.com' => new Contact(LastName = 'Walker', FirstName = 'Camila', Email = 'CamilaWalker@testmail.com'),
            'AveryPaterson@testmail.com' => new Contact(LastName = 'Paterson', FirstName = 'Avery', Email = 'AveryPaterson@testmail.com'),
            'RyileeYoung@testmail.com' => new Contact(LastName = 'Young', FirstName = 'Ryilee', Email = 'RyileeYoung@testmail.com'),
            'LaylaWatson@testmail.com' => new Contact(LastName = 'Watson', FirstName = 'Layla', Email = 'LaylaWatson@testmail.com'),
            'ScarlettMorrison@testmail.com' => new Contact(LastName = 'Morrison', FirstName = 'Scarlett', Email = 'ScarlettMorrison@testmail.com'),
            'LilyMiller@testmail.com' => new Contact(LastName = 'Miller', FirstName = 'Lily', Email = 'LilyMiller@testmail.com'),
            'SofiaFraser@testmail.com' => new Contact(LastName = 'Fraser', FirstName = 'Sofia', Email = 'SofiaFraser@testmail.com'),
            'NovaDavidson@testmail.com' => new Contact(LastName = 'Davidson', FirstName = 'Nova', Email = 'NovaDavidson@testmail.com'),
            'AuroraGray@testmail.com' => new Contact(LastName = 'Gray', FirstName = 'Aurora', Email = 'AuroraGray@testmail.com'),
            'AbigailMcdonald@testmail.com' => new Contact(LastName = 'Mcdonald', FirstName = 'Abigail', Email = 'AbigailMcdonald@testmail.com'),
            'ChloeHenderson@testmail.com' => new Contact(LastName = 'Henderson', FirstName = 'Chloe', Email = 'ChloeHenderson@testmail.com'),
            'RileyJohnston@testmail.com' => new Contact(LastName = 'Johnston', FirstName = 'Riley', Email = 'RileyJohnston@testmail.com'),
            'HazelHamilton@testmail.com' => new Contact(LastName = 'Hamilton', FirstName = 'Hazel', Email = 'HazelHamilton@testmail.com'),
            'NoraGraham@testmail.com' => new Contact(LastName = 'Graham', FirstName = 'Nora', Email = 'NoraGraham@testmail.com'),
            'ZoeyKerr@testmail.com' => new Contact(LastName = 'Kerr', FirstName = 'Zoey', Email = 'ZoeyKerr@testmail.com'),
            'IslaSimpson@testmail.com' => new Contact(LastName = 'Simpson', FirstName = 'Isla', Email = 'IslaSimpson@testmail.com'),
            'PenelopeMartin@testmail.com' => new Contact(LastName = 'Martin', FirstName = 'Penelope', Email = 'PenelopeMartin@testmail.com'),
            'ElizabethFerguson@testmail.com' => new Contact(LastName = 'Ferguson', FirstName = 'Elizabeth', Email = 'ElizabethFerguson@testmail.com'),
            'EleanorCameron@testmail.com' => new Contact(LastName = 'Cameron', FirstName = 'Eleanor', Email = 'EleanorCameron@testmail.com'),
            'ElenaDuncan@testmail.com' => new Contact(LastName = 'Duncan', FirstName = 'Elena', Email = 'ElenaDuncan@testmail.com'),
            'MadisonHunter@testmail.com' => new Contact(LastName = 'Hunter', FirstName = 'Madison', Email = 'MadisonHunter@testmail.com'),
            'EmiliaKelly@testmail.com' => new Contact(LastName = 'Kelly', FirstName = 'Emilia', Email = 'EmiliaKelly@testmail.com'),
            'EmilyBell@testmail.com' => new Contact(LastName = 'Bell', FirstName = 'Emily', Email = 'EmilyBell@testmail.com'),
            'ElianaGrant@testmail.com' => new Contact(LastName = 'Grant', FirstName = 'Eliana', Email = 'ElianaGrant@testmail.com'),
            'WillowMackenzie@testmail.com' => new Contact(LastName = 'Mackenzie', FirstName = 'Willow', Email = 'WillowMackenzie@testmail.com'),
            'MayaMackay@testmail.com' => new Contact(LastName = 'Mackay', FirstName = 'Maya', Email = 'MayaMackay@testmail.com'),
            'StellaAllan@testmail.com' => new Contact(LastName = 'Allan', FirstName = 'Stella', Email = 'StellaAllan@testmail.com'),
            'VioletBlack@testmail.com' => new Contact(LastName = 'Black', FirstName = 'Violet', Email = 'VioletBlack@testmail.com'),
            'AddisonMacleod@testmail.com' => new Contact(LastName = 'Macleod', FirstName = 'Addison', Email = 'AddisonMacleod@testmail.com'),
            'PaisleyMclean@testmail.com' => new Contact(LastName = 'Mclean', FirstName = 'Paisley', Email = 'PaisleyMclean@testmail.com'),
            'EverlyRussell@testmail.com' => new Contact(LastName = 'Russell', FirstName = 'Everly', Email = 'EverlyRussell@testmail.com'),
            'HannahGibson@testmail.com' => new Contact(LastName = 'Gibson', FirstName = 'Hannah', Email = 'HannahGibson@testmail.com'),
            'LitteWallace@testmail.com' => new Contact(LastName = 'Wallace', FirstName = 'Litte', Email = 'LitteWallace@testmail.com'),
            'IvyGordon@testmail.com' => new Contact(LastName = 'Gordon', FirstName = 'Ivy', Email = 'IvyGordon@testmail.com'),
            'LiamMarshall@testmail.com' => new Contact(LastName = 'Marshall', FirstName = 'Liam', Email = 'LiamMarshall@testmail.com'),
            'NoahStevenson@testmail.com' => new Contact(LastName = 'Stevenson', FirstName = 'Noah', Email = 'NoahStevenson@testmail.com'),
            'OliverWood@testmail.com' => new Contact(LastName = 'Wood', FirstName = 'Oliver', Email = 'OliverWood@testmail.com'),
            'ElijahSutherland@testmail.com' => new Contact(LastName = 'Sutherland', FirstName = 'Elijah', Email = 'ElijahSutherland@testmail.com'),
            'LucasCraig@testmail.com' => new Contact(LastName = 'Craig', FirstName = 'Lucas', Email = 'LucasCraig@testmail.com'),
            'MasonWright@testmail.com' => new Contact(LastName = 'Wright', FirstName = 'Mason', Email = 'MasonWright@testmail.com'),
            'LeviMckenzie@testmail.com' => new Contact(LastName = 'Mckenzie', FirstName = 'Levi', Email = 'LeviMckenzie@testmail.com'),
            'JamesKennedy@testmail.com' => new Contact(LastName = 'Kennedy', FirstName = 'James', Email = 'JamesKennedy@testmail.com'),
            'MateoJones@testmail.com' => new Contact(LastName = 'Jones', FirstName = 'Mateo', Email = 'MateoJones@testmail.com'),
            'AsherBurns@testmail.com' => new Contact(LastName = 'Burns', FirstName = 'Asher', Email = 'AsherBurns@testmail.com'),
            'BenjaminWhite@testmail.com' => new Contact(LastName = 'White', FirstName = 'Benjamin', Email = 'BenjaminWhite@testmail.com'),
            'AidenMuir@testmail.com' => new Contact(LastName = 'Muir', FirstName = 'Aiden', Email = 'AidenMuir@testmail.com'),
            'LoganMurphy@testmail.com' => new Contact(LastName = 'Murphy', FirstName = 'Logan', Email = 'LoganMurphy@testmail.com'),
            'EthanJohnstone@testmail.com' => new Contact(LastName = 'Johnstone', FirstName = 'Ethan', Email = 'EthanJohnstone@testmail.com'),
            'LeoHughes@testmail.com' => new Contact(LastName = 'Hughes', FirstName = 'Leo', Email = 'LeoHughes@testmail.com'),
            'JackWatt@testmail.com' => new Contact(LastName = 'Watt', FirstName = 'Jack', Email = 'JackWatt@testmail.com'),
            'JacksonMcmillan@testmail.com' => new Contact(LastName = 'Mcmillan', FirstName = 'Jackson', Email = 'JacksonMcmillan@testmail.com'),
            'LerielMcintosh@testmail.com' => new Contact(LastName = 'Mcintosh', FirstName = 'Leriel', Email = 'LerielMcintosh@testmail.com'),
            'HenryMilne@testmail.com' => new Contact(LastName = 'Milne', FirstName = 'Henry', Email = 'HenryMilne@testmail.com'),
            'GraysonMunro@testmail.com' => new Contact(LastName = 'Munro', FirstName = 'Grayson', Email = 'GraysonMunro@testmail.com'),
            'WyattRitchie@testmail.com' => new Contact(LastName = 'Ritchie', FirstName = 'Wyatt', Email = 'WyattRitchie@testmail.com'),
            'CarterDickson@testmail.com' => new Contact(LastName = 'Dickson', FirstName = 'Carter', Email = 'CarterDickson@testmail.com'),
            'SebastianBruce@testmail.com' => new Contact(LastName = 'Bruce', FirstName = 'Sebastian', Email = 'SebastianBruce@testmail.com'),
            'WilliamKing@testmail.com' => new Contact(LastName = 'King', FirstName = 'William', Email = 'WilliamKing@testmail.com'),
            'DanielCrawford@testmail.com' => new Contact(LastName = 'Crawford', FirstName = 'Daniel', Email = 'DanielCrawford@testmail.com'),
            'OwenDocherty@testmail.com' => new Contact(LastName = 'Docherty', FirstName = 'Owen', Email = 'OwenDocherty@testmail.com'),
            'JulianMillar@testmail.com' => new Contact(LastName = 'Millar', FirstName = 'Julian', Email = 'JulianMillar@testmail.com'),
            'AlexanderCunningham@testmail.com' => new Contact(LastName = 'Cunningham', FirstName = 'Alexander', Email = 'AlexanderCunningham@testmail.com'),
            'MichaelSinclair@testmail.com' => new Contact(LastName = 'Sinclair', FirstName = 'Michael', Email = 'MichaelSinclair@testmail.com'),
            'EzraWilliamson@testmail.com' => new Contact(LastName = 'Williamson', FirstName = 'Ezra', Email = 'EzraWilliamson@testmail.com'),
            'MuhammadHill@testmail.com' => new Contact(LastName = 'Hill', FirstName = 'Muhammad', Email = 'MuhammadHill@testmail.com'),
            'HudsonMcgregor@testmail.com' => new Contact(LastName = 'Mcgregor', FirstName = 'Hudson', Email = 'HudsonMcgregor@testmail.com'),
            'LukeMckay@testmail.com' => new Contact(LastName = 'Mckay', FirstName = 'Luke', Email = 'LukeMckay@testmail.com'),
            'LincolnBoyle@testmail.com' => new Contact(LastName = 'Boyle', FirstName = 'Lincoln', Email = 'LincolnBoyle@testmail.com'),
            'GabrielShaw@testmail.com' => new Contact(LastName = 'Shaw', FirstName = 'Gabriel', Email = 'GabrielShaw@testmail.com'),
            'SamuelFleming@testmail.com' => new Contact(LastName = 'Fleming', FirstName = 'Samuel', Email = 'SamuelFleming@testmail.com'),
            'JacobMoore@testmail.com' => new Contact(LastName = 'Moore', FirstName = 'Jacob', Email = 'JacobMoore@testmail.com'),
            'JosiahChristie@testmail.com' => new Contact(LastName = 'Christie', FirstName = 'Josiah', Email = 'JosiahChristie@testmail.com'),
            'JaydenDouglas@testmail.com' => new Contact(LastName = 'Douglas', FirstName = 'Jayden', Email = 'JaydenDouglas@testmail.com'),
            'MaverickDonaldson@testmail.com' => new Contact(LastName = 'Donaldson', FirstName = 'Maverick', Email = 'MaverickDonaldson@testmail.com'),
            'DavidAlexander@testmail.com' => new Contact(LastName = 'Alexander', FirstName = 'David', Email = 'DavidAlexander@testmail.com'),
            'EliasMaclean@testmail.com' => new Contact(LastName = 'Maclean', FirstName = 'Elias', Email = 'EliasMaclean@testmail.com'),
            'JaxonForbes@testmail.com' => new Contact(LastName = 'Forbes', FirstName = 'Jaxon', Email = 'JaxonForbes@testmail.com'),
            'MatthewWilliams@testmail.com' => new Contact(LastName = 'Williams', FirstName = 'Matthew', Email = 'MatthewWilliams@testmail.com'),
            'EliMcintyre@testmail.com' => new Contact(LastName = 'Mcintyre', FirstName = 'Eli', Email = 'EliMcintyre@testmail.com'),
            'LucaFindlay@testmail.com' => new Contact(LastName = 'Findlay', FirstName = 'Luca', Email = 'LucaFindlay@testmail.com'),
            'AnthonyJamieson@testmail.com' => new Contact(LastName = 'Jamieson', FirstName = 'Anthony', Email = 'AnthonyJamieson@testmail.com'),
            'IsaiahAitken@testmail.com' => new Contact(LastName = 'Aitken', FirstName = 'Isaiah', Email = 'IsaiahAitken@testmail.com'),
            'KaiReilly@testmail.com' => new Contact(LastName = 'Reilly', FirstName = 'Kai', Email = 'KaiReilly@testmail.com'),
            'JohnThompson@testmail.com' => new Contact(LastName = 'Thompson', FirstName = 'John', Email = 'JohnThompson@testmail.com'),
            'DaisyIrish@testmail.com' => new Contact(LastName = 'Irish', FirstName = 'Daisy', Email = 'DaisyIrish@testmail.com'),
            'ReeseBaker@testmail.com' => new Contact(LastName = 'Baker', FirstName = 'Reese', Email = 'ReeseBaker@testmail.com'),
            'ValerieHall@testmail.com' => new Contact(LastName = 'Hall', FirstName = 'Valerie', Email = 'ValerieHall@testmail.com'),
            'BriannaRivera@testmail.com' => new Contact(LastName = 'Rivera', FirstName = 'Brianna', Email = 'BriannaRivera@testmail.com'),
            'CeciliaCampbell@testmail.com' => new Contact(LastName = 'Campbell', FirstName = 'Cecilia', Email = 'CeciliaCampbell@testmail.com'),
            'AndreaMitchell@testmail.com' => new Contact(LastName = 'Mitchell', FirstName = 'Andrea', Email = 'AndreaMitchell@testmail.com'),
            'SummerCarter@testmail.com' => new Contact(LastName = 'Carter', FirstName = 'Summer', Email = 'SummerCarter@testmail.com'),
            'ValeriaRoberts@testmail.com' => new Contact(LastName = 'Roberts', FirstName = 'Valeria', Email = 'ValeriaRoberts@testmail.com'),
            'NorahGomez@testmail.com' => new Contact(LastName = 'Gomez', FirstName = 'Norah', Email = 'NorahGomez@testmail.com'),
            'AriellaPhillips@testmail.com' => new Contact(LastName = 'Phillips', FirstName = 'Ariella', Email = 'AriellaPhillips@testmail.com'),
            'EstherEvans@testmail.com' => new Contact(LastName = 'Evans', FirstName = 'Esther', Email = 'EstherEvans@testmail.com'),
            'AshleyTurner@testmail.com' => new Contact(LastName = 'Turner', FirstName = 'Ashley', Email = 'AshleyTurner@testmail.com'),
            'EmersonDiaz@testmail.com' => new Contact(LastName = 'Diaz', FirstName = 'Emerson', Email = 'EmersonDiaz@testmail.com'),
            'AubreeParker@testmail.com' => new Contact(LastName = 'Parker', FirstName = 'Aubree', Email = 'AubreeParker@testmail.com'),
            'IsabelCruz@testmail.com' => new Contact(LastName = 'Cruz', FirstName = 'Isabel', Email = 'IsabelCruz@testmail.com'),
            'AnastasiaEdwards@testmail.com' => new Contact(LastName = 'Edwards', FirstName = 'Anastasia', Email = 'AnastasiaEdwards@testmail.com'),
            'RyleighCollins@testmail.com' => new Contact(LastName = 'Collins', FirstName = 'Ryleigh', Email = 'RyleighCollins@testmail.com'),
            'KhloeReyes@testmail.com' => new Contact(LastName = 'Reyes', FirstName = 'Khloe', Email = 'KhloeReyes@testmail.com'),
            'TaylorStewart@testmail.com' => new Contact(LastName = 'Stewart', FirstName = 'Taylor', Email = 'TaylorStewart@testmail.com'),
            'LondynMorris@testmail.com' => new Contact(LastName = 'Morris', FirstName = 'Londyn', Email = 'LondynMorris@testmail.com'),
            'LuciaMorales@testmail.com' => new Contact(LastName = 'Morales', FirstName = 'Lucia', Email = 'LuciaMorales@testmail.com'),
            'EmersynMurphy@testmail.com' => new Contact(LastName = 'Murphy', FirstName = 'Emersyn', Email = 'EmersynMurphy@testmail.com'),
            'CallieCook@testmail.com' => new Contact(LastName = 'Cook', FirstName = 'Callie', Email = 'CallieCook@testmail.com'),
            'SiennaRogers@testmail.com' => new Contact(LastName = 'Rogers', FirstName = 'Sienna', Email = 'SiennaRogers@testmail.com'),
            'BlakelyGutierrez@testmail.com' => new Contact(LastName = 'Gutierrez', FirstName = 'Blakely', Email = 'BlakelyGutierrez@testmail.com'),
            'KehlaniOrtiz@testmail.com' => new Contact(LastName = 'Ortiz', FirstName = 'Kehlani', Email = 'KehlaniOrtiz@testmail.com'),
            'GenevieveMorgan@testmail.com' => new Contact(LastName = 'Morgan', FirstName = 'Genevieve', Email = 'GenevieveMorgan@testmail.com'),
            'AlinaCooper@testmail.com' => new Contact(LastName = 'Cooper', FirstName = 'Alina', Email = 'AlinaCooper@testmail.com'),
            'BaileyPeterson@testmail.com' => new Contact(LastName = 'Peterson', FirstName = 'Bailey', Email = 'BaileyPeterson@testmail.com'),
            'JuniperBailey@testmail.com' => new Contact(LastName = 'Bailey', FirstName = 'Juniper', Email = 'JuniperBailey@testmail.com'),
            'MaeveReed@testmail.com' => new Contact(LastName = 'Reed', FirstName = 'Maeve', Email = 'MaeveReed@testmail.com'),
            'MollyKelly@testmail.com' => new Contact(LastName = 'Kelly', FirstName = 'Molly', Email = 'MollyKelly@testmail.com'),
            'HarmonyHoward@testmail.com' => new Contact(LastName = 'Howard', FirstName = 'Harmony', Email = 'HarmonyHoward@testmail.com'),
            'GeorgiaRamos@testmail.com' => new Contact(LastName = 'Ramos', FirstName = 'Georgia', Email = 'GeorgiaRamos@testmail.com'),
            'SuttonKim@testmail.com' => new Contact(LastName = 'Kim', FirstName = 'Sutton', Email = 'SuttonKim@testmail.com'),
            'BooneCox@testmail.com' => new Contact(LastName = 'Cox', FirstName = 'Boone', Email = 'BooneCox@testmail.com'),
            'SaintWard@testmail.com' => new Contact(LastName = 'Ward', FirstName = 'Saint', Email = 'SaintWard@testmail.com'),
            'SaulRichardson@testmail.com' => new Contact(LastName = 'Richardson', FirstName = 'Saul', Email = 'SaulRichardson@testmail.com'),
            'JazielWatson@testmail.com' => new Contact(LastName = 'Watson', FirstName = 'Jaziel', Email = 'JazielWatson@testmail.com'),
            'HezekiahBrooks@testmail.com' => new Contact(LastName = 'Brooks', FirstName = 'Hezekiah', Email = 'HezekiahBrooks@testmail.com'),
            'AlecChavez@testmail.com' => new Contact(LastName = 'Chavez', FirstName = 'Alec', Email = 'AlecChavez@testmail.com'),
            'ArturoWood@testmail.com' => new Contact(LastName = 'Wood', FirstName = 'Arturo', Email = 'ArturoWood@testmail.com'),
            'JamariJames@testmail.com' => new Contact(LastName = 'James', FirstName = 'Jamari', Email = 'JamariJames@testmail.com'),
            'JaxtynBennet@testmail.com' => new Contact(LastName = 'Bennet', FirstName = 'Jaxtyn', Email = 'JaxtynBennet@testmail.com'),
            'JulienGray@testmail.com' => new Contact(LastName = 'Gray', FirstName = 'Julien', Email = 'JulienGray@testmail.com'),
            'KoaMendoza@testmail.com' => new Contact(LastName = 'Mendoza', FirstName = 'Koa', Email = 'KoaMendoza@testmail.com'),
            'ReeceRuiz@testmail.com' => new Contact(LastName = 'Ruiz', FirstName = 'Reece', Email = 'ReeceRuiz@testmail.com'),
            'LandenHughes@testmail.com' => new Contact(LastName = 'Hughes', FirstName = 'Landen', Email = 'LandenHughes@testmail.com'),
            'KodaPrice@testmail.com' => new Contact(LastName = 'Price', FirstName = 'Koda', Email = 'KodaPrice@testmail.com'),
            'DariusAlvarez@testmail.com' => new Contact(LastName = 'Alvarez', FirstName = 'Darius', Email = 'DariusAlvarez@testmail.com'),
            'SylasCastillo@testmail.com' => new Contact(LastName = 'Castillo', FirstName = 'Sylas', Email = 'SylasCastillo@testmail.com'),
            'AresSanders@testmail.com' => new Contact(LastName = 'Sanders', FirstName = 'Ares', Email = 'AresSanders@testmail.com'),
            'KyreePatel@testmail.com' => new Contact(LastName = 'Patel', FirstName = 'Kyree', Email = 'KyreePatel@testmail.com'),
            'KatyaKar@testmail.com' => new Contact(LastName = 'Katya', FirstName = 'Kar', Email = 'KatyaKar@testmail.com')
    };
}