# gra-platformowa
Gry zręcznościowej, w której postać porusza się po wielopoziomowych platformach.
[Link do gry w wersij online](https://microstudio.io/Benekin/graplatformowazelementamisi222246/PG5U2RH8/)

# Środowisko
Gra została napisana w MicroStudio, który jest darmowym silnikiem służącym do tworzenia gier online. Udostępniony jest on w formie strony internetowej. Wszystkie pliki przechowywane są w chmurze, przez co projekt można otworzyć na dowolnym urządzeniu, bez potrzeby kopiowania lub udostępniania plików. Istnieje możliwość korzystania z silnika offline, bez konieczności łączenia się z internetem. Środowisko posiada wszystkie niezbędne narzędzia umożliwiające tworzenie podstawowych gier. MicroStudio jest środowiskiem dynamicznie rozwijającym się. Na moment rozpoczęcia prac nad implementowaną grą, dostępny był jedynie język microscript. Wraz z upływem czasu baza dostępnych języków została rozszerzona.

# Fabuła
Stworzona na potrzeby pracy gra należy do gatunku gier platformowych (tzw. platformówek), w której gracz wciela się w postać ninjy. Celem rozgrywki jest ukoń- czenie dwóch różnych poziomów gry, w których napotykamy trzy typy przeciwników
wyposażonych w sztuczną inteligencję oraz liczne przeszkody, aby finalnie zmierzyć się z tzw. bossem, którego pokonanie jest równoznaczne z zakończeniem gry. Systemem walki głównej postaci są shurikeny (rodzaj broni do rzucania, którą posługuje się gracz oraz oponenci) wykorzystywane do eliminowania antagonistów oraz specjalna umiejętność tzw. chidori, która służy w trakcie finałowej walki do niszczenia tarczy generowanej przez bossa.

# Zastosowany język oraz biblioteka graficzna 
Gra została w całości napisana w języku microScript, który inspirowany jest językiem Lua. Główne cechy języka to:
+ zmienne są domyślnie globalne;
+ nie ma wartości null, nil lub undefined;
+ każda niezdefiniowana lub pusta zmienna ma wartość 0;
+ funkcja init odpowiada za inicjalizację zmiennej i wywoływana jest tylko raz podczas działania programu;
+ funkcja update jest wywoływana 60 razy na sekundę. Wnętrze tej funkcji jest przeznaczone do programowania logiki oraz fizyki gry;
+ Funkcja draw jest wywoływana tak często jak można odświeżyć ekran, służy do rysowania oraz umieszczania gotowych elementów.
W projekcie wykorzystano bibliotekę basic graphic API, która w zupełności wystarczy do stworzenia prostej gry platformowej

# Fizyka
Fizyka opiera się na utworzeniu siatki mapy, na podstawie której wyliczane jest położenie gracza oraz innych obiektów, które nie są rysowane bezpośrednio w edytorze map, lecz dodawane jako oddzielne elementy. Jeśli występuje kolizja pomiędzy skrajnymi punktami niewidocznego hitboxa (obszar otaczający obiekt, pozwalający wykryć kolizję) znajdującego się przy obiekcie, a elementami mapy traktowanymi jako podłoże lub drabina, następuje interakcja. Jeśli gracz skacze, przyciąganie na osi Oy wzrasta, dzięki czemu występuje imitacja grawitacji.

# Mapa
Gra składa się z dwóch poziomów. Mapa ma wymiary 64 na 32 bloki, z których każdy ma 16x16px, tak więc wymiar w pikselach wynosi 1024 na 512. Level zawiera elementy, które są natychmiastowo rysowane w edytorze map oraz te, które są dodawane niezależnie. Bloki dzielą się na umożliwiające interakcję z graczem oraz pełniące wyłącznie funkcję estetyczną

# Bohater
Postać przedstawia ninję, ma wymiary 16x16px, została narysowana w edytorze sprite'y. Poza głównym widokiem, w którym postać stoi nieruchomo, utworzonych zostało kilka animacji odpowiadających za chodzenie, skok, wspinanie się po drabinie, rzuty shurikenem. Animacja składa się z oddzielnych klatek. Każda klatka ma tę samą wielkość.

# SI
W grze można wyróżnić 4 typy przeciwników. W każdym z nich działanie sztucznej inteligencji opiera się na prostym drzewie decyzyjnym.

