#!/bin/sh

echo "Updating and installing Docker"
sudo yum update -y
sudo yum upgrade -y
sudo yum remove docker \
  docker-client \
  docker-client-latest \
  docker-common \
  docker-latest \
  docker-latest-logrotate \
  docker-logrotate \
  docker-engine
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2
sudo yum-config-manager -y \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io

echo "Starting and enabling Docker"
sudo systemctl start docker
sudo systemctl enable docker

sudo docker rm --force postgres || true

sudo docker run -d \
  --name postgres \
  -e POSTGRES_USER=admin \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=forum \
  -p 80:5432 \
  -p 5432:5432 \
  -p 6080:5432 \
  --restart always \
  postgres:11.3-alpine

sudo docker exec -i postgres psql -U admin -d forum <<-EOF
create table posts (
    id SERIAL PRIMARY KEY,
    body TEXT NOT NULL,
    author_name VARCHAR(50) NOT NULL,
    created_on TIMESTAMP NOT NULL DEFAULT NOW()
);
create table comments (
    id SERIAL PRIMARY KEY,
    post_id INTEGER REFERENCES posts(id),
    comment TEXT NOT NULL,
    sentiment VARCHAR(10) NOT NULL,
    commenter_name VARCHAR(50) NOT NULL,
    created_on TIMESTAMP NOT NULL DEFAULT NOW()
);

insert into posts (body, author_name) values ('Voluptatem voluptatem eius numquam neque magnam.', 'Nelson Schacht');
insert into posts (body, author_name) values ('Praesent ac felis nec odio malesuada rutrum.', 'Carey Buck');
insert into posts (body, author_name) values ('Ut non nibh hendrerit, vestibulum nisl accumsan, pretium turpis.', 'Edwina Maddox');
insert into posts (body, author_name) values ('Sed malesuada erat et consectetur tempus.', 'Sylvia Lyons');
insert into posts (body, author_name) values ('Praesent tempus nisl at elit pharetra euismod.', 'Evangelina Mata');
insert into posts (body, author_name) values ('Nam rhoncus erat sollicitudin urna condimentum, a venenatis augue dignissim.', 'Nathanial Olson');
insert into posts (body, author_name) values ('Quisque tristique tortor ac nibh fringilla, id malesuada magna cursus.', 'Sonya Werner');
insert into posts (body, author_name) values ('Donec nec erat vitae ligula porta tincidunt a sit amet urna.', 'Blair Kelley');
insert into posts (body, author_name) values ('Quisque volutpat ex ac felis faucibus, a eleifend ante ultricies.', 'Rodolfo Schwartz');
insert into posts (body, author_name) values ('Nulla tincidunt dui et arcu feugiat, sed posuere purus rhoncus.', 'Allyson Holloway');
insert into posts (body, author_name) values ('Quisque et orci id nibh pulvinar ornare.', 'Robin Kaiser');
insert into posts (body, author_name) values ('Duis eget sapien euismod, consectetur tortor vel, posuere erat.', 'Bart Nicholson');
insert into posts (body, author_name) values ('Ut rhoncus ex non dolor rhoncus interdum.', 'Nickolas Valenzuela');
insert into posts (body, author_name) values ('Vestibulum eget tellus mollis, sollicitudin urna vitae, mattis massa.', 'Julian Newman');
insert into posts (body, author_name) values ('Vivamus sed augue iaculis dolor convallis molestie.', 'Eddie Thomas');
insert into posts (body, author_name) values ('Donec sagittis tellus vitae varius aliquet.', 'Ingrid Jefferson');
insert into posts (body, author_name) values ('Fusce eu quam ac tortor volutpat dapibus.', 'Kerri Krueger');
insert into posts (body, author_name) values ('Sed vel justo cursus, pharetra eros quis, accumsan nibh.', 'Clement Huynh');
insert into posts (body, author_name) values ('Duis bibendum sem quis lectus laoreet varius.', 'Clair Hinton');
insert into posts (body, author_name) values ('Fusce lacinia diam tempus finibus malesuada.', 'Glen Cisneros');
insert into posts (body, author_name) values ('Suspendisse vel libero eu elit consequat scelerisque.', 'Andy Berry');
insert into posts (body, author_name) values ('Fusce malesuada dui vestibulum enim scelerisque ultricies.', 'Valarie Hale');
insert into posts (body, author_name) values ('Integer eleifend lorem vitae finibus ultrices.', 'Francis Weaver');
insert into posts (body, author_name) values ('Nulla ac mauris eleifend, faucibus dui eget, rhoncus purus.', 'Ken Dougherty');
insert into posts (body, author_name) values ('Maecenas bibendum ligula et metus tincidunt, sit amet elementum arcu facilisis.', 'Marion Orr');
insert into posts (body, author_name) values ('Integer volutpat felis quis dui tristique, id mollis velit euismod.', 'Jeannette Barry');
insert into posts (body, author_name) values ('Suspendisse sed diam congue, tincidunt turpis vestibulum, lacinia nunc.', 'Rudolph Carr');
insert into posts (body, author_name) values ('Cras vehicula augue sit amet mauris tincidunt faucibus.', 'Dale Yates');
insert into posts (body, author_name) values ('Vivamus lacinia ex in pulvinar facilisis.', 'Burt Hudson');
insert into posts (body, author_name) values ('Pellentesque non est id leo fringilla pretium vel sed eros.', 'Bryan Andrade');
insert into posts (body, author_name) values ('Cras dictum risus in nunc pulvinar viverra.', 'Carlene Andersen');
insert into posts (body, author_name) values ('Morbi suscipit justo nec lorem egestas viverra.', 'Velma Wolfe');
insert into posts (body, author_name) values ('Suspendisse semper orci eget mauris malesuada tempus.', 'Marisa Barr');
insert into posts (body, author_name) values ('Proin ac ante quis orci sollicitudin egestas nec vitae risus.', 'Murray Horton');
insert into posts (body, author_name) values ('Curabitur mollis justo et egestas aliquet.', 'Norman Stout');
insert into posts (body, author_name) values ('Proin eget lectus a dolor fringilla vulputate.', 'Karen Vargas');
insert into posts (body, author_name) values ('Quisque tincidunt mi id mollis mattis.', 'Waylon Sexton');
insert into posts (body, author_name) values ('Nullam a sapien ac leo viverra pretium.', 'Bradford Mccullough');
insert into posts (body, author_name) values ('Duis ultricies odio at metus tristique, eu commodo erat faucibus.', 'Xavier Cox');
insert into posts (body, author_name) values ('Sed id neque semper, vestibulum elit sit amet, iaculis libero.', 'Brittany Downs');
insert into posts (body, author_name) values ('Maecenas ornare lacus non lectus fermentum, eget accumsan arcu aliquam.', 'Ella Whitaker');
insert into posts (body, author_name) values ('Aliquam tristique nisl et dolor maximus tristique.', 'Noreen Valencia');
insert into posts (body, author_name) values ('Sed pulvinar massa et massa accumsan tempor.', 'Lowell Cordova');
insert into posts (body, author_name) values ('Duis non augue a arcu accumsan posuere eu sed justo.', 'Vincent Wilson');
insert into posts (body, author_name) values ('Suspendisse ornare massa a sem laoreet, nec rutrum lacus ultricies.', 'Pat Hayden');
insert into posts (body, author_name) values ('Quisque elementum lacus non urna volutpat ornare.', 'Berta Mckay');
insert into posts (body, author_name) values ('Aliquam posuere neque id cursus tempor.', 'Meagan Ramirez');
insert into posts (body, author_name) values ('Maecenas consectetur justo sit amet eros mollis, dictum condimentum erat vestibulum.', 'Amber Avery');
insert into posts (body, author_name) values ('Mauris sit amet arcu sed turpis bibendum tincidunt et fringilla nunc.', 'Clyde York');
insert into posts (body, author_name) values ('Ut eu magna id nisi gravida varius non at ipsum.', 'Ron Stephens');
insert into posts (body, author_name) values ('Morbi malesuada urna eget tristique pellentesque.', 'Rosario Armstrong');
insert into comments (post_id, comment, sentiment, commenter_name) values (1, 'Aliquam sed dolor numquam non. Quiquia velit etincidunt est ipsum. Numquam tempora etincidunt velit sed quisquam. Etincidunt ipsum amet etincidunt adipisci ut modi. Numquam aliquam velit dolorem quisquam dolorem voluptatem. Dolor velit quiquia sit etincidunt eius aliquam. Est magnam aliquam eius est consectetur tempora. Quaerat modi quiquia adipisci modi quaerat tempora quisquam. Sit neque sit sed quisquam porro dolore. Labore dolorem tempora eius adipisci ipsum adipisci.', 'positive', 'James Chavez');
insert into comments (post_id, comment, sentiment, commenter_name) values (2, 'Adipisci est numquam dolor. Ut sed dolor quaerat quisquam. Porro dolorem ut tempora quaerat dolore. Dolorem ipsum quisquam sit voluptatem adipisci numquam. Neque quisquam dolore est. Velit tempora etincidunt porro. Etincidunt adipisci modi etincidunt velit aliquam tempora quaerat.', 'positive', 'Jay Dots');
insert into comments (post_id, comment, sentiment, commenter_name) values (3, 'Quiquia aliquam numquam dolore. Porro ipsum eius tempora. Tempora velit dolorem dolorem ipsum porro ut. Magnam etincidunt neque modi etincidunt est consectetur sit. Voluptatem etincidunt voluptatem quaerat. Tempora sit eius non ut magnam labore. Ut adipisci sit tempora sed eius quaerat est. Sit consectetur dolore dolore velit non. Dolor quisquam dolore eius dolorem sit. Eius velit etincidunt quaerat.', 'positive', 'Golda Wattle');
insert into comments (post_id, comment, sentiment, commenter_name) values (4, 'Ut ipsum numquam porro aliquam sed neque sed. Ut non aliquam non aliquam ipsum labore eius. Consectetur dolorem neque neque adipisci aliquam magnam. Modi quaerat sed labore quisquam eius. Velit eius dolor labore magnam non porro. Modi voluptatem dolor consectetur neque. Aliquam amet neque eius sit tempora labore est. Dolor sed velit neque porro modi ipsum.', 'negative', 'Oriole Sweets');
insert into comments (post_id, comment, sentiment, commenter_name) values (5, 'Dolorem tempora sed etincidunt dolorem adipisci neque. Velit dolor porro etincidunt sed eius dolorem. Dolorem amet adipisci quaerat non dolorem. Quisquam quiquia voluptatem neque modi neque. Porro ut porro quiquia ipsum eius ut. Sed labore quisquam tempora ut. Ut adipisci adipisci consectetur est est dolorem. Eius neque quaerat aliquam ipsum tempora.', 'positive', 'Virgie Bricks');
insert into comments (post_id, comment, sentiment, commenter_name) values (6, 'Tempora labore amet ipsum aliquam. Non quaerat labore neque ipsum quaerat neque dolorem. Ipsum quaerat velit porro. Sit tempora quaerat dolor neque quiquia. Ut adipisci labore aliquam labore labore quiquia porro. Modi numquam quisquam voluptatem. Quisquam quisquam aliquam labore modi est adipisci dolorem. Quiquia est non est quisquam porro modi modi.', 'negative', 'Hayley Books');
insert into comments (post_id, comment, sentiment, commenter_name) values (7, 'Dolorem modi numquam quiquia sit numquam quisquam. Voluptatem voluptatem porro sit modi neque. Quaerat modi numquam velit. Labore quisquam adipisci dolor est. Dolorem modi adipisci etincidunt.', 'negative', 'Leif Snakebark');
insert into comments (post_id, comment, sentiment, commenter_name) values (8, 'Quaerat sed dolorem sit. Voluptatem dolore dolorem labore dolore. Dolore voluptatem etincidunt velit consectetur voluptatem. Labore labore adipisci quaerat ut. Numquam adipisci dolorem quaerat aliquam amet aliquam adipisci. Labore magnam non numquam numquam. Sit quaerat sed sit etincidunt voluptatem non. Modi adipisci ipsum dolorem ipsum. Ut quisquam amet labore magnam.', 'negative', 'Eleanor Fingerling');
insert into comments (post_id, comment, sentiment, commenter_name) values (9, 'Consectetur sed quaerat ipsum voluptatem magnam velit. Aliquam amet magnam etincidunt. Voluptatem consectetur quisquam sit. Ipsum consectetur tempora sed dolorem consectetur. Porro quaerat est consectetur.', 'positive', 'Meda Elderberry');
insert into comments (post_id, comment, sentiment, commenter_name) values (10, 'Modi tempora magnam sed voluptatem quaerat. Sit quiquia sed porro etincidunt porro. Sed quisquam quisquam velit non aliquam amet eius. Dolor voluptatem numquam non labore velit. Adipisci quaerat velit quisquam. Sit etincidunt magnam amet dolor quiquia. Est amet quiquia sit. Consectetur ipsum neque etincidunt quisquam est.', 'negative', 'Delta Sweetleaf');
insert into comments (post_id, comment, sentiment, commenter_name) values (11, 'Numquam quiquia neque dolor eius modi amet. Amet dolor labore sit ut quisquam dolorem. Quaerat magnam ut ipsum modi. Voluptatem consectetur adipisci neque amet labore. Quisquam porro sit dolore velit non tempora. Neque ut quiquia est neque neque ipsum aliquam. Numquam numquam adipisci sit dolore quaerat. Consectetur labore porro porro.', 'positive', 'Onyx Crooks');
insert into comments (post_id, comment, sentiment, commenter_name) values (12, 'Voluptatem sit numquam porro dolorem non. Neque eius ipsum dolor est dolore consectetur. Labore sed voluptatem amet ipsum neque adipisci neque. Numquam amet porro tempora ipsum quiquia. Labore labore quisquam amet aliquam est eius.', 'negative', 'Galaxy Eaglet');
insert into comments (post_id, comment, sentiment, commenter_name) values (13, 'Dolor consectetur dolorem etincidunt. Magnam numquam porro velit sed numquam. Magnam non dolore quisquam quaerat ut adipisci. Est labore neque quisquam tempora dolorem quaerat. Labore modi modi labore consectetur labore aliquam neque. Numquam quiquia consectetur consectetur numquam. Adipisci neque ipsum sit tempora dolore eius quiquia. Etincidunt consectetur quisquam magnam dolor modi sit.', 'positive', 'Zona Bullwark');
insert into comments (post_id, comment, sentiment, commenter_name) values (14, 'Tempora amet dolore numquam dolore sed. Amet dolor etincidunt voluptatem modi. Neque labore dolore ipsum magnam tempora neque sed. Porro porro voluptatem non amet eius. Est quaerat quiquia magnam dolorem aliquam porro.', 'negative', 'Bronze Fiddlewood');
insert into comments (post_id, comment, sentiment, commenter_name) values (15, 'Consectetur voluptatem quiquia ut. Ut numquam sed quaerat ipsum aliquam non dolor. Ut dolor eius neque labore eius quiquia. Ipsum neque neque ut amet sed. Quisquam velit sed amet tempora ipsum. Velit tempora magnam consectetur est. Tempora eius ut eius etincidunt. Aliquam non dolor neque ut ipsum quiquia. Modi sit sed eius labore ut.', 'negative', 'Bill Bags');
insert into comments (post_id, comment, sentiment, commenter_name) values (16, 'Dolore adipisci sed magnam modi voluptatem aliquam est. Est non tempora adipisci voluptatem est dolore dolore. Sed neque quisquam magnam ipsum. Est numquam dolor est quisquam sed magnam numquam. Tempora modi sed adipisci. Tempora magnam magnam aliquam modi consectetur dolore.', 'positive', 'Finch Primrose');
insert into comments (post_id, comment, sentiment, commenter_name) values (17, 'Porro labore sed ipsum sed porro non. Porro non etincidunt quiquia modi. Tempora voluptatem magnam eius sit ipsum. Quisquam dolor eius adipisci. Tempora non quiquia aliquam non neque eius. Labore sit dolorem non voluptatem aliquam.', 'negative', 'Wong Hearth');
insert into comments (post_id, comment, sentiment, commenter_name) values (18, 'Ut quaerat sed porro quiquia sed labore. Eius dolorem sit non amet porro. Non dolore adipisci dolor etincidunt ipsum non voluptatem. Eius quaerat adipisci quisquam quisquam ipsum dolor. Dolore ut tempora sed quiquia velit non dolorem.', 'negative', 'Lagoon Mandrake');
insert into comments (post_id, comment, sentiment, commenter_name) values (19, 'Sed labore porro labore voluptatem consectetur dolor. Voluptatem dolore non quisquam dolorem magnam neque amet. Sit aliquam consectetur dolor quiquia. Ut quisquam modi quaerat velit magnam dolor. Etincidunt tempora adipisci dolore dolor ipsum voluptatem ipsum. Ut ut ut consectetur sed magnam adipisci labore. Labore numquam eius etincidunt adipisci. Ipsum velit ipsum dolor dolorem amet.', 'negative', 'Spruce Tauris');
insert into comments (post_id, comment, sentiment, commenter_name) values (20, 'Magnam porro voluptatem magnam dolore. Adipisci numquam etincidunt aliquam dolorem numquam modi. Neque amet etincidunt dolor. Voluptatem amet consectetur ut modi velit. Porro amet modi eius etincidunt quiquia neque. Amet etincidunt sit quiquia magnam etincidunt eius. Quaerat modi voluptatem quisquam tempora magnam adipisci. Porro etincidunt quisquam ut aliquam ipsum velit.', 'positive', 'Axel Mole');
insert into comments (post_id, comment, sentiment, commenter_name) values (21, 'Etincidunt amet quiquia etincidunt velit dolore. Sit sit dolor amet ipsum. Dolorem quaerat dolor labore. Voluptatem sit ipsum velit. Non modi non velit. Dolorem numquam velit porro dolore non magnam dolore. Sed est quiquia etincidunt.', 'negative', 'Sylvia Night');
insert into comments (post_id, comment, sentiment, commenter_name) values (22, 'Amet est sit ipsum velit. Porro neque porro sed dolor adipisci ut quiquia. Consectetur est dolorem quaerat. Labore est sit est adipisci. Dolore non quisquam etincidunt sed. Numquam non velit eius non voluptatem quiquia.', 'positive', 'Annie Squabs');
insert into comments (post_id, comment, sentiment, commenter_name) values (23, 'Adipisci quaerat etincidunt dolorem adipisci magnam. Sit non dolore non magnam sit non. Amet adipisci sed aliquam est quisquam numquam quisquam. Sed tempora modi dolorem. Dolore ut non aliquam. Adipisci magnam porro consectetur est. Dolore modi dolor voluptatem numquam quisquam numquam. Sed aliquam etincidunt dolorem. Quaerat dolorem ut labore voluptatem neque amet.', 'negative', 'Elektra Minks');
insert into comments (post_id, comment, sentiment, commenter_name) values (24, 'Ut dolor dolore adipisci dolor etincidunt. Non magnam est amet. Sed quisquam ipsum quiquia ut. Dolor eius dolor quisquam dolore porro sed modi. Porro modi dolorem ut. Numquam ipsum dolor dolor. Quisquam sit sit est eius adipisci ipsum.', 'positive', 'Francis Kelpis');
insert into comments (post_id, comment, sentiment, commenter_name) values (25, 'Labore sit amet adipisci voluptatem dolorem. Adipisci est dolor ut quisquam magnam porro. Eius neque eius neque sed quaerat quaerat. Dolor ut quiquia est adipisci. Modi quisquam neque dolor. Quaerat voluptatem magnam neque voluptatem. Ut quaerat aliquam modi porro magnam labore quisquam. Sed est eius dolore ut non.', 'negative', 'Mica Ferret');
insert into comments (post_id, comment, sentiment, commenter_name) values (26, 'Adipisci dolor ipsum sit non dolorem porro. Velit modi numquam sed numquam. Est voluptatem porro quaerat eius quiquia. Numquam voluptatem modi consectetur. Etincidunt dolore quisquam consectetur. Quiquia dolor dolor ut eius quisquam sed. Consectetur quiquia magnam porro sit est consectetur sed. Ut quisquam tempora est non tempora adipisci. Ut aliquam eius velit. Quiquia labore numquam amet ut.', 'negative', 'Ruellia Everglade');
insert into comments (post_id, comment, sentiment, commenter_name) values (27, 'Ipsum velit numquam est sed sed. Dolore numquam tempora ipsum etincidunt. Non modi tempora consectetur tempora voluptatem eius. Sit ipsum eius eius ipsum dolorem eius dolorem. Eius quaerat eius amet dolore ut velit neque.', 'negative', 'Chervil Horsetail');
insert into comments (post_id, comment, sentiment, commenter_name) values (28, 'Consectetur etincidunt etincidunt est ut numquam. Voluptatem labore etincidunt velit labore. Porro voluptatem quaerat ipsum magnam. Est voluptatem neque velit velit eius ut tempora. Dolor adipisci aliquam porro est. Magnam quiquia consectetur dolorem sed quaerat ipsum labore. Dolorem consectetur dolorem quiquia etincidunt.', 'positive', 'Phoenix Bucket');
insert into comments (post_id, comment, sentiment, commenter_name) values (29, 'Eius magnam sed adipisci. Magnam eius tempora porro dolor non voluptatem quaerat. Eius adipisci dolore est dolor. Velit dolorem modi magnam quaerat. Ut numquam neque est labore est. Etincidunt velit labore est aliquam sed. Labore dolore etincidunt etincidunt velit amet. Porro magnam amet dolorem labore velit eius.', 'positive', 'Leif Dime');
insert into comments (post_id, comment, sentiment, commenter_name) values (30, 'Porro aliquam quiquia dolorem. Voluptatem etincidunt sed neque. Ipsum etincidunt numquam labore quaerat quaerat sit non. Dolor quisquam eius labore eius quaerat. Quisquam eius velit eius numquam eius tempora. Voluptatem tempora est tempora labore consectetur velit. Velit magnam sit ipsum eius. Velit quaerat amet quisquam. Quisquam dolorem consectetur quaerat modi sit sed non. Sit eius dolorem numquam.', 'positive', 'Breeze Gosling');
insert into comments (post_id, comment, sentiment, commenter_name) values (31, 'Ut quisquam velit numquam labore. Non quiquia sit adipisci dolore aliquam ut. Amet eius quiquia ut voluptatem adipisci. Dolore tempora amet magnam sed quisquam dolorem aliquam. Dolor sed magnam porro velit quiquia magnam. Non eius ut modi tempora voluptatem. Dolorem est non quaerat consectetur porro. Etincidunt eius non porro. Voluptatem porro velit dolore ipsum sed velit magnam.', 'positive', 'Haven Locket');
insert into comments (post_id, comment, sentiment, commenter_name) values (32, 'Amet tempora quaerat eius amet dolore adipisci. Adipisci adipisci quisquam quisquam. Dolor magnam magnam quiquia quisquam. Etincidunt sit sed consectetur quisquam. Ipsum voluptatem consectetur est. Voluptatem sit aliquam est neque sit tempora.', 'negative', 'Angel Hatch');
insert into comments (post_id, comment, sentiment, commenter_name) values (33, 'Voluptatem est magnam ut. Est quaerat dolore ut modi ut. Ut numquam etincidunt etincidunt tempora aliquam. Magnam dolore quiquia dolor ipsum porro. Non aliquam magnam labore dolor dolor velit voluptatem. Dolore porro sit tempora.', 'negative', 'Axel Strongbark');
insert into comments (post_id, comment, sentiment, commenter_name) values (34, 'Aliquam aliquam eius sed ipsum labore. Labore sit quisquam neque modi porro. Quaerat numquam amet eius ut labore. Non porro eius sed quiquia tempora. Eius modi voluptatem amet etincidunt est. Quaerat quaerat modi aliquam. Tempora sed sit sed porro magnam consectetur eius. Non magnam labore porro dolorem adipisci etincidunt. Quisquam quaerat labore aliquam est dolorem.', 'positive', 'Sunny Hemlock');
insert into comments (post_id, comment, sentiment, commenter_name) values (35, 'Tempora magnam dolorem quiquia neque. Ut porro non quiquia aliquam porro magnam eius. Eius adipisci numquam quiquia neque aliquam adipisci magnam. Etincidunt ipsum non ipsum dolorem. Quiquia dolore aliquam velit quaerat amet amet. Amet est non modi eius non dolor neque. Labore neque magnam tempora magnam voluptatem. Etincidunt porro dolorem amet ipsum numquam sed sed.', 'positive', 'Elektra Hearth');
insert into comments (post_id, comment, sentiment, commenter_name) values (36, 'Velit quiquia etincidunt sed magnam magnam. Sit consectetur magnam non velit. Tempora adipisci voluptatem sed. Dolore dolore labore non porro non quaerat sed. Quiquia porro aliquam quisquam amet dolor. Ut non voluptatem dolorem neque neque.', 'positive', 'Nova Pineneedle');
insert into comments (post_id, comment, sentiment, commenter_name) values (37, 'Tempora sit dolor voluptatem sit amet quiquia. Quisquam numquam consectetur etincidunt magnam. Eius sed ut adipisci dolorem modi adipisci. Dolorem porro dolorem sit modi tempora modi dolore. Eius dolor etincidunt quaerat. Consectetur est adipisci ut tempora quisquam voluptatem. Non non aliquam quiquia est. Est amet est sed sed quiquia est. Non neque velit consectetur quaerat. Modi tempora voluptatem quiquia dolorem.', 'positive', 'Travis Willows');
insert into comments (post_id, comment, sentiment, commenter_name) values (38, 'Etincidunt magnam adipisci tempora eius quaerat numquam adipisci. Velit labore non quisquam. Dolorem etincidunt est modi quisquam quiquia etincidunt tempora. Ut consectetur velit eius velit aliquam tempora etincidunt. Quaerat sit dolor sit. Dolor non velit sit quisquam sed labore voluptatem. Ipsum voluptatem neque porro velit tempora.', 'positive', 'Olivia Hammers');
insert into comments (post_id, comment, sentiment, commenter_name) values (39, 'Amet voluptatem aliquam sit labore. Sed amet ut est. Non ipsum est quisquam tempora. Dolorem quaerat numquam ipsum amet eius. Velit adipisci eius ut dolore. Eius dolor etincidunt quisquam non etincidunt.', 'negative', 'Nova Cobris');
insert into comments (post_id, comment, sentiment, commenter_name) values (40, 'Adipisci neque quiquia modi dolore dolorem. Eius neque amet magnam quaerat sit velit sit. Est modi eius quiquia modi non etincidunt. Aliquam amet magnam quaerat quaerat amet. Voluptatem magnam magnam non tempora etincidunt consectetur eius.', 'positive', 'Allen Griffin');
insert into comments (post_id, comment, sentiment, commenter_name) values (41, 'Eius modi velit quaerat voluptatem. Quiquia quiquia dolorem neque modi quiquia. Etincidunt velit ipsum non amet dolorem. Ut dolore quiquia sit voluptatem. Amet dolore consectetur modi.', 'negative', 'Hiram Buttonwood');
insert into comments (post_id, comment, sentiment, commenter_name) values (42, 'Adipisci porro sit dolorem dolore eius. Velit magnam dolore dolorem porro aliquam eius ipsum. Magnam dolor neque velit tempora quiquia neque velit. Ipsum neque numquam eius non. Quisquam ipsum magnam dolore sed non ut.', 'negative', 'Mathew Copper');
insert into comments (post_id, comment, sentiment, commenter_name) values (43, 'Numquam quiquia neque voluptatem quaerat. Eius quiquia ut ut. Consectetur dolor adipisci voluptatem voluptatem tempora neque eius. Amet neque eius est ipsum dolore numquam. Magnam etincidunt quaerat aliquam ipsum dolorem quiquia. Ut labore non modi dolor magnam. Labore dolore sit non.', 'positive', 'Frederic Gooseberry');
insert into comments (post_id, comment, sentiment, commenter_name) values (44, 'Aliquam est adipisci velit sit dolore voluptatem. Aliquam porro dolor est. Tempora non amet quisquam modi sed eius voluptatem. Amet dolor voluptatem eius. Non sit ut neque quiquia adipisci quaerat. Magnam eius quisquam tempora neque quaerat ipsum amet. Quisquam quaerat ut sed adipisci. Quisquam velit ut dolore quisquam non. Tempora quisquam dolor eius numquam modi. Non tempora sed aliquam labore consectetur.', 'positive', 'Dell Ferlet');
insert into comments (post_id, comment, sentiment, commenter_name) values (45, 'Est est amet eius est. Voluptatem dolore modi non amet consectetur aliquam. Eius adipisci quaerat dolore dolore voluptatem velit dolor. Labore dolore dolorem amet est. Est dolore consectetur quisquam. Modi dolore aliquam ipsum.', 'positive', 'Sidney Dovetail');
insert into comments (post_id, comment, sentiment, commenter_name) values (46, 'Voluptatem dolore consectetur magnam est consectetur dolor. Dolorem aliquam est ipsum. Ut quaerat magnam labore non. Tempora voluptatem quaerat ut. Voluptatem numquam ut labore. Tempora numquam quisquam dolor velit est sed ut.', 'positive', 'Lala Rubis');
insert into comments (post_id, comment, sentiment, commenter_name) values (47, 'Voluptatem dolore eius ipsum dolorem ut. Consectetur ipsum consectetur neque dolor magnam. Sed dolorem porro dolorem voluptatem consectetur. Sed non est sit neque. Numquam magnam ipsum non sed consectetur.', 'positive', 'Rock Asp');
insert into comments (post_id, comment, sentiment, commenter_name) values (48, 'Dolorem porro labore adipisci dolore ut voluptatem. Adipisci magnam ipsum ut dolore. Eius dolore dolor voluptatem dolore. Quisquam amet etincidunt sit ut porro. Magnam dolore sit tempora dolorem.', 'negative', 'Dawn Mallow');
insert into comments (post_id, comment, sentiment, commenter_name) values (49, 'Dolorem amet labore dolore. Aliquam amet modi ut velit consectetur voluptatem labore. Eius eius numquam eius labore labore. Sed ut etincidunt sed neque voluptatem magnam est. Ipsum quisquam porro amet eius porro. Tempora amet dolor velit aliquam dolor ut. Dolore quaerat quisquam dolore dolor magnam. Amet aliquam sed quaerat modi sit amet.', 'positive', 'Talon Cygnet');
insert into comments (post_id, comment, sentiment, commenter_name) values (50, 'Sit aliquam consectetur eius adipisci aliquam. Dolor eius modi ipsum. Tempora tempora etincidunt quisquam. Ipsum porro labore non consectetur etincidunt non eius. Voluptatem numquam etincidunt labore etincidunt. Est neque quisquam quaerat quaerat etincidunt.', 'positive', 'Willa Felide');
insert into comments (post_id, comment, sentiment, commenter_name) values (51, 'Non neque neque dolore quaerat magnam etincidunt porro. Labore tempora est numquam neque modi labore. Quisquam dolore dolor dolorem voluptatem. Voluptatem dolorem dolorem etincidunt consectetur neque ut est. Velit dolorem magnam est quiquia labore non. Voluptatem dolor dolor ut dolorem tempora labore.', 'positive', 'Wellington Oleander');
EOF
