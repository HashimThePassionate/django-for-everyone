insert into
  store_collection (id, title, featured_product_id)
values
  (1, 'Flowers', null),
  (2, 'Grocery', null),
  (3, 'Beauty', null),
  (4, 'Cleaning', null),
  (5, 'Stationary', null),
  (6, 'Pets', null),
  (7, 'Baking', null),
  (8, 'Spices', null),
  (9, 'Toys', null),
  (10, 'Magazines', null);

insert into
  store_product (
    id,
    title,
    description,
    unit_price,
    inventory,
    last_update,
    collection_id,
    slug
  )
values
  (
    1,
    'Bread Ww Cluster',
    'mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus',
    4.00,
    11,
    '2020-09-11 00:00:00',
    6,
    '-'
  ),
  (
    2,
    'Island Oasis - Raspberry',
    'maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque',
    84.64,
    40,
    '2020-07-07 00:00:00',
    3,
    '-'
  ),
  (
    3,
    'Shrimp - 21/25, Peel And Deviened',
    'nisi volutpat eleifend donec ut dolor morbi vel lectus in quam',
    11.52,
    29,
    '2021-04-05 00:00:00',
    3,
    '-'
  ),
  (
    4,
    'Wood Chips - Regular',
    'posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut',
    73.47,
    40,
    '2020-07-20 00:00:00',
    5,
    '-'
  ),
  (
    5,
    'Lettuce - Mini Greens, Whole',
    'lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc',
    60.21,
    56,
    '2020-08-18 00:00:00',
    5,
    '-'
  ),
  (
    6,
    'Mustard - Individual Pkg',
    'pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna',
    76.62,
    18,
    '2020-10-25 00:00:00',
    6,
    '-'
  ),
  (
    7,
    'Turkey Tenderloin Frozen',
    'sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim',
    13.64,
    48,
    '2020-08-08 00:00:00',
    4,
    '-'
  ),
  (
    8,
    'Silicone Parch. 16.3x24.3',
    'faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis',
    85.76,
    55,
    '2021-06-03 00:00:00',
    6,
    '-'
  ),
  (
    9,
    'Tomatoes - Cherry, Yellow',
    'sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing',
    30.81,
    45,
    '2021-03-03 00:00:00',
    5,
    '-'
  ),
  (
    10,
    'Sloe Gin - Mcguinness',
    'fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa',
    2.82,
    69,
    '2021-04-18 00:00:00',
    5,
    '-'
  ),
  (
    11,
    'Wine - Magnotta - Belpaese',
    'ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo',
    37.72,
    71,
    '2021-01-19 00:00:00',
    6,
    '-'
  ),
  (
    12,
    'Beer - Alexander Kieths, Pale Ale',
    'nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa',
    92.74,
    55,
    '2020-12-28 00:00:00',
    3,
    '-'
  ),
  (
    13,
    'Basil - Thai',
    'rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum',
    50.07,
    41,
    '2020-07-07 00:00:00',
    6,
    '-'
  ),
  (
    14,
    'Tofu - Soft',
    'at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula',
    88.70,
    24,
    '2020-08-29 00:00:00',
    4,
    '-'
  ),
  (
    15,
    'Mayonnaise - Individual Pkg',
    'id luctus nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et',
    81.81,
    35,
    '2020-07-25 00:00:00',
    4,
    '-'
  ),
  (
    16,
    'Sauce - Hollandaise',
    'blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer pede',
    9.09,
    63,
    '2020-07-16 00:00:00',
    6,
    '-'
  ),
  (
    17,
    'Salt - Rock, Course',
    'congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut',
    41.53,
    60,
    '2021-03-05 00:00:00',
    3,
    '-'
  ),
  (
    18,
    'Beef - Ox Tail, Frozen',
    'donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien',
    80.97,
    85,
    '2020-07-26 00:00:00',
    4,
    '-'
  ),
  (
    19,
    'Schnappes - Peach, Walkers',
    'phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in',
    81.97,
    10,
    '2021-05-14 00:00:00',
    5,
    '-'
  ),
  (
    20,
    'Cheese - Parmesan Cubes',
    'ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra',
    32.94,
    97,
    '2020-08-12 00:00:00',
    3,
    '-'
  ),
  (
    21,
    'Sweet Pea Sprouts',
    'lectus aliquam sit amet diam in magna bibendum imperdiet nullam',
    31.93,
    49,
    '2021-01-14 00:00:00',
    5,
    '-'
  ),
  (
    22,
    'Straw - Regular',
    'nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel',
    76.59,
    56,
    '2020-11-13 00:00:00',
    5,
    '-'
  ),
  (
    23,
    'Peach - Fresh',
    'feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien',
    2.95,
    63,
    '2021-01-22 00:00:00',
    6,
    '-'
  ),
  (
    24,
    'Chinese Foods - Pepper Beef',
    'nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris',
    86.30,
    64,
    '2020-10-31 00:00:00',
    3,
    '-'
  ),
  (
    25,
    'Guava',
    'erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a',
    17.53,
    96,
    '2021-05-05 00:00:00',
    4,
    '-'
  ),
  (
    26,
    'Tendrils - Baby Pea, Organic',
    'lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat',
    18.18,
    0,
    '2021-03-24 00:00:00',
    3,
    '-'
  ),
  (
    27,
    'Sugar - Brown',
    'lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui',
    65.01,
    84,
    '2020-10-24 00:00:00',
    5,
    '-'
  ),
  (
    28,
    'Oil - Pumpkinseed',
    'cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis',
    86.27,
    90,
    '2021-02-11 00:00:00',
    5,
    '-'
  ),
  (
    29,
    'Beef - Tongue, Cooked',
    'sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo',
    73.48,
    82,
    '2021-02-07 00:00:00',
    6,
    '-'
  ),
  (
    30,
    'Goat - Leg',
    'vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in',
    83.98,
    66,
    '2021-03-01 00:00:00',
    4,
    '-'
  ),
  (
    31,
    'Orange Roughy 4/6 Oz',
    'id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie',
    99.48,
    79,
    '2021-05-26 00:00:00',
    5,
    '-'
  ),
  (
    32,
    'Lemons',
    'et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit',
    29.08,
    83,
    '2021-06-03 00:00:00',
    5,
    '-'
  ),
  (
    33,
    'Turnip - Mini',
    'id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat',
    13.93,
    8,
    '2021-03-23 00:00:00',
    6,
    '-'
  ),
  (
    34,
    'Hinge W Undercut',
    'in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices',
    20.24,
    45,
    '2020-08-23 00:00:00',
    3,
    '-'
  ),
  (
    35,
    'Cheese - Mozzarella',
    'nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla',
    34.71,
    76,
    '2020-10-13 00:00:00',
    3,
    '-'
  ),
  (
    36,
    'Basil - Fresh',
    'pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu',
    11.80,
    2,
    '2021-06-07 00:00:00',
    4,
    '-'
  ),
  (
    37,
    'Pastry - Choclate Baked',
    'rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at',
    61.87,
    12,
    '2020-11-17 00:00:00',
    3,
    '-'
  ),
  (
    38,
    'Vol Au Vents',
    'non mauris morbi non lectus aliquam sit amet diam in',
    81.78,
    98,
    '2021-04-29 00:00:00',
    5,
    '-'
  ),
  (
    39,
    'Tomatoes - Roma',
    'turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum',
    29.81,
    61,
    '2020-09-04 00:00:00',
    4,
    '-'
  ),
  (
    40,
    'Bread - Hamburger Buns',
    'vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget',
    51.39,
    8,
    '2021-04-07 00:00:00',
    5,
    '-'
  ),
  (
    41,
    'Cheese - Cambozola',
    'vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non',
    64.20,
    54,
    '2020-12-22 00:00:00',
    3,
    '-'
  ),
  (
    42,
    'Cup - 4oz Translucent',
    'mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a',
    71.97,
    52,
    '2020-08-29 00:00:00',
    5,
    '-'
  ),
  (
    43,
    'Macaroons - Two Bite Choc',
    'tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien',
    14.87,
    38,
    '2021-05-15 00:00:00',
    6,
    '-'
  ),
  (
    44,
    'Vinegar - Raspberry',
    'platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie',
    52.43,
    88,
    '2021-02-10 00:00:00',
    6,
    '-'
  ),
  (
    45,
    'Cake - Night And Day Choclate',
    'magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer',
    84.60,
    93,
    '2020-09-26 00:00:00',
    3,
    '-'
  ),
  (
    46,
    'Wine - Domaine Boyar Royal',
    'ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam',
    39.61,
    92,
    '2020-07-14 00:00:00',
    6,
    '-'
  ),
  (
    47,
    'Sword Pick Asst',
    'nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer',
    75.08,
    15,
    '2021-04-28 00:00:00',
    3,
    '-'
  ),
  (
    48,
    'Sage - Ground',
    'ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl',
    16.75,
    94,
    '2021-06-06 00:00:00',
    6,
    '-'
  ),
  (
    49,
    'Muffin Mix - Chocolate Chip',
    'ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis vel',
    93.49,
    16,
    '2020-07-07 00:00:00',
    3,
    '-'
  ),
  (
    50,
    'Tia Maria',
    'morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam',
    69.22,
    14,
    '2020-06-11 00:00:00',
    4,
    '-'
  ),
  (
    51,
    'Apple - Fuji',
    'in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus',
    20.42,
    94,
    '2021-05-05 00:00:00',
    3,
    '-'
  ),
  (
    52,
    'Veal - Tenderloin, Untrimmed',
    'cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien',
    89.46,
    44,
    '2020-06-14 00:00:00',
    4,
    '-'
  ),
  (
    53,
    'Mushroom - Crimini',
    'ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur',
    42.13,
    58,
    '2021-01-19 00:00:00',
    3,
    '-'
  ),
  (
    54,
    'Parsley Italian - Fresh',
    'rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis',
    85.92,
    93,
    '2021-04-24 00:00:00',
    3,
    '-'
  ),
  (
    55,
    'Tart - Pecan Butter Squares',
    'in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst',
    91.98,
    43,
    '2020-09-06 00:00:00',
    4,
    '-'
  ),
  (
    56,
    'Vinegar - Tarragon',
    'orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum',
    7.30,
    60,
    '2021-05-09 00:00:00',
    5,
    '-'
  ),
  (
    57,
    'Beef - Tender Tips',
    'nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum',
    8.83,
    5,
    '2021-01-01 00:00:00',
    3,
    '-'
  ),
  (
    58,
    'Chicken - Whole Roasting',
    'id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci',
    47.43,
    11,
    '2021-04-07 00:00:00',
    3,
    '-'
  ),
  (
    59,
    'Water - Tonic',
    'sit amet eleifend pede libero quis orci nullam molestie nibh',
    36.84,
    13,
    '2020-08-14 00:00:00',
    6,
    '-'
  ),
  (
    60,
    'Shrimp - Tiger 21/25',
    'nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer',
    64.38,
    100,
    '2020-07-21 00:00:00',
    4,
    '-'
  ),
  (
    61,
    'Hagen Daza - Dk Choocolate',
    'sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere',
    37.63,
    43,
    '2020-09-25 00:00:00',
    6,
    '-'
  ),
  (
    62,
    'Grenadillo',
    'lorem ipsum dolor sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius',
    14.57,
    34,
    '2020-10-14 00:00:00',
    6,
    '-'
  ),
  (
    63,
    'Coffee - 10oz Cup 92961',
    'quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet',
    26.36,
    34,
    '2020-09-22 00:00:00',
    5,
    '-'
  ),
  (
    64,
    'Seabream Whole Farmed',
    'interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis',
    59.91,
    32,
    '2021-02-13 00:00:00',
    5,
    '-'
  ),
  (
    65,
    'Coconut Milk - Unsweetened',
    'felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque',
    79.79,
    12,
    '2021-03-10 00:00:00',
    4,
    '-'
  ),
  (
    66,
    'Soap - Mr.clean Floor Soap',
    'consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum',
    38.03,
    31,
    '2020-06-13 00:00:00',
    5,
    '-'
  ),
  (
    67,
    'Cheese - Cambozola',
    'tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc',
    19.49,
    33,
    '2021-01-13 00:00:00',
    5,
    '-'
  ),
  (
    68,
    'Soup Campbells Mexicali Tortilla',
    'pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat',
    93.16,
    7,
    '2021-04-14 00:00:00',
    5,
    '-'
  ),
  (
    69,
    'Apron',
    'amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse',
    4.66,
    6,
    '2021-02-10 00:00:00',
    4,
    '-'
  ),
  (
    70,
    'Wine - Penfolds Koonuga Hill',
    'aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut',
    1.27,
    15,
    '2020-12-10 00:00:00',
    3,
    '-'
  ),
  (
    71,
    'Milk - Chocolate 250 Ml',
    'gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras',
    1.88,
    25,
    '2020-08-19 00:00:00',
    5,
    '-'
  ),
  (
    72,
    'Beer - Paulaner Hefeweisse',
    'lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci',
    36.96,
    43,
    '2020-10-10 00:00:00',
    4,
    '-'
  ),
  (
    73,
    'Chocolate - Feathers',
    'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris',
    65.35,
    50,
    '2020-11-02 00:00:00',
    4,
    '-'
  ),
  (
    74,
    'Club Soda - Schweppes, 355 Ml',
    'duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at',
    90.39,
    72,
    '2021-04-13 00:00:00',
    3,
    '-'
  ),
  (
    75,
    'Corn Kernels - Frozen',
    'odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum',
    98.61,
    53,
    '2020-10-12 00:00:00',
    4,
    '-'
  ),
  (
    76,
    'Cheese Cloth No 60',
    'posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet',
    66.25,
    72,
    '2020-12-08 00:00:00',
    3,
    '-'
  ),
  (
    77,
    'Chips - Assorted',
    'nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus',
    86.36,
    93,
    '2020-07-06 00:00:00',
    3,
    '-'
  ),
  (
    78,
    'Bagelers',
    'eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim',
    82.37,
    39,
    '2020-08-29 00:00:00',
    4,
    '-'
  ),
  (
    79,
    'Corn - Cream, Canned',
    'in consequat ut nulla sed accumsan felis ut at dolor quis odio consequat varius integer ac leo pellentesque',
    85.46,
    24,
    '2021-05-13 00:00:00',
    3,
    '-'
  ),
  (
    80,
    'Bread - Raisin',
    'donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis',
    8.70,
    70,
    '2020-07-09 00:00:00',
    4,
    '-'
  ),
  (
    81,
    'Soup - Campbells',
    'turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci',
    8.13,
    29,
    '2020-12-15 00:00:00',
    5,
    '-'
  ),
  (
    82,
    'Ecolab - Hobart Washarm End Cap',
    'placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt',
    83.36,
    67,
    '2020-10-25 00:00:00',
    5,
    '-'
  ),
  (
    83,
    'Asparagus - White, Canned',
    'in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst',
    71.01,
    17,
    '2020-07-27 00:00:00',
    3,
    '-'
  ),
  (
    84,
    'Muffin Mix - Lemon Cranberry',
    'ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo',
    47.63,
    11,
    '2020-12-23 00:00:00',
    6,
    '-'
  ),
  (
    85,
    'Shrimp - 16/20, Peeled Deviened',
    'parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor',
    1.08,
    58,
    '2021-06-07 00:00:00',
    5,
    '-'
  ),
  (
    86,
    'Soda Water - Club Soda, 355 Ml',
    'faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus',
    90.06,
    88,
    '2021-05-04 00:00:00',
    3,
    '-'
  ),
  (
    87,
    'Napkin White - Starched',
    'quam nec dui luctus rutrum nulla tellus in sagittis dui',
    30.95,
    52,
    '2020-10-10 00:00:00',
    5,
    '-'
  ),
  (
    88,
    'Beer - Steamwhistle',
    'nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet',
    11.89,
    59,
    '2020-06-20 00:00:00',
    3,
    '-'
  ),
  (
    89,
    'Pail For Lid 1537',
    'in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices',
    35.85,
    92,
    '2020-10-11 00:00:00',
    6,
    '-'
  ),
  (
    90,
    'Chinese Foods - Chicken Wing',
    'purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus',
    28.87,
    48,
    '2020-12-28 00:00:00',
    3,
    '-'
  ),
  (
    91,
    'Spice - Montreal Steak Spice',
    'donec dapibus duis at velit eu est congue elementum in',
    35.71,
    32,
    '2021-05-15 00:00:00',
    5,
    '-'
  ),
  (
    92,
    'Juice - Grapefruit, 341 Ml',
    'vestibulum proin eu mi nulla ac enim in tempor turpis nec',
    33.37,
    26,
    '2020-07-16 00:00:00',
    5,
    '-'
  ),
  (
    93,
    'Wine - Wyndham Estate Bin 777',
    'pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus',
    3.34,
    87,
    '2020-12-29 00:00:00',
    5,
    '-'
  ),
  (
    94,
    'Water - Mineral, Natural',
    'pretium quis lectus suspendisse potenti in eleifend quam a odio in hac',
    61.59,
    71,
    '2020-07-16 00:00:00',
    5,
    '-'
  ),
  (
    95,
    'Chicken - Leg, Boneless',
    'eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin',
    84.83,
    15,
    '2020-06-21 00:00:00',
    3,
    '-'
  ),
  (
    96,
    'Sunflower Seed Raw',
    'volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat',
    28.16,
    2,
    '2020-10-19 00:00:00',
    3,
    '-'
  ),
  (
    97,
    'Energy Drink Bawls',
    'risus praesent lectus vestibulum quam sapien varius ut blandit non',
    87.65,
    31,
    '2021-02-23 00:00:00',
    6,
    '-'
  ),
  (
    98,
    'Tarragon - Primerba, Paste',
    'non quam nec dui luctus rutrum nulla tellus in sagittis',
    20.87,
    38,
    '2020-08-11 00:00:00',
    3,
    '-'
  ),
  (
    99,
    'Table Cloth 62x120 Colour',
    'et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis',
    27.91,
    96,
    '2021-03-20 00:00:00',
    3,
    '-'
  ),
  (
    100,
    'Lamb - Loin Chops',
    'praesent id massa id nisl venenatis lacinia aenean sit amet justo',
    87.47,
    40,
    '2021-02-20 00:00:00',
    3,
    '-'
  ),
  (
    101,
    'Sherry - Dry',
    'morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit',
    70.52,
    32,
    '2020-06-27 00:00:00',
    6,
    '-'
  ),
  (
    102,
    'Chickensplit Half',
    'congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue',
    93.81,
    66,
    '2021-03-02 00:00:00',
    4,
    '-'
  ),
  (
    103,
    'Tea - Orange Pekoe',
    'vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus',
    12.71,
    77,
    '2020-07-12 00:00:00',
    3,
    '-'
  ),
  (
    104,
    'Sauce - Caesar Dressing',
    'orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis',
    98.89,
    62,
    '2020-09-03 00:00:00',
    3,
    '-'
  ),
  (
    105,
    'Rice - Brown',
    'lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra',
    83.88,
    24,
    '2020-06-20 00:00:00',
    6,
    '-'
  ),
  (
    106,
    'Soup - Knorr, Ministrone',
    'rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia',
    4.88,
    22,
    '2020-07-30 00:00:00',
    5,
    '-'
  ),
  (
    107,
    'Wine - Cotes Du Rhone Parallele',
    'risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam',
    13.89,
    10,
    '2021-04-13 00:00:00',
    3,
    '-'
  ),
  (
    108,
    'Chips Potato All Dressed - 43g',
    'faucibus accumsan odio curabitur convallis duis consequat dui nec nisi',
    35.65,
    13,
    '2020-10-23 00:00:00',
    3,
    '-'
  ),
  (
    109,
    'Sugar - Crumb',
    'aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea',
    5.07,
    95,
    '2021-01-08 00:00:00',
    3,
    '-'
  ),
  (
    110,
    'Ice Cream - Strawberry',
    'posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel',
    22.63,
    7,
    '2021-04-06 00:00:00',
    4,
    '-'
  ),
  (
    111,
    'Paper Cocktail Umberlla 80 - 180',
    'sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate',
    94.11,
    94,
    '2021-04-14 00:00:00',
    3,
    '-'
  ),
  (
    112,
    'Salmon - Canned',
    'est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et',
    80.67,
    59,
    '2021-02-26 00:00:00',
    6,
    '-'
  ),
  (
    113,
    'Seedlings - Buckwheat, Organic',
    'vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus',
    44.29,
    80,
    '2020-08-14 00:00:00',
    5,
    '-'
  ),
  (
    114,
    'Cheese - Brie, Triple Creme',
    'sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus',
    46.60,
    66,
    '2020-08-06 00:00:00',
    3,
    '-'
  ),
  (
    115,
    'Phyllo Dough',
    'risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula',
    35.53,
    45,
    '2021-02-03 00:00:00',
    3,
    '-'
  ),
  (
    116,
    'Pastry - Banana Muffin - Mini',
    'vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa',
    85.57,
    59,
    '2020-12-29 00:00:00',
    4,
    '-'
  ),
  (
    117,
    'Jameson - Irish Whiskey',
    'non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel',
    65.52,
    97,
    '2020-11-25 00:00:00',
    3,
    '-'
  ),
  (
    118,
    'Praline Paste',
    'in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec',
    57.27,
    3,
    '2021-04-02 00:00:00',
    3,
    '-'
  ),
  (
    119,
    'Flour - Fast / Rapid',
    'suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae',
    77.83,
    79,
    '2020-11-03 00:00:00',
    5,
    '-'
  ),
  (
    120,
    'Sausage - Meat',
    'enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem',
    49.77,
    44,
    '2020-06-22 00:00:00',
    6,
    '-'
  ),
  (
    121,
    'Wine - Vovray Sec Domaine Huet',
    'tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut',
    2.20,
    84,
    '2021-01-11 00:00:00',
    4,
    '-'
  ),
  (
    122,
    'Ecolab - Hand Soap Form Antibac',
    'amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut',
    44.58,
    96,
    '2020-09-17 00:00:00',
    4,
    '-'
  ),
  (
    123,
    'Melon - Honey Dew',
    'quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse',
    57.94,
    55,
    '2021-04-24 00:00:00',
    4,
    '-'
  ),
  (
    124,
    'Dill - Primerba, Paste',
    'ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl',
    97.81,
    72,
    '2020-11-11 00:00:00',
    6,
    '-'
  ),
  (
    125,
    'Pork - Ham, Virginia',
    'sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus',
    97.58,
    74,
    '2021-03-06 00:00:00',
    3,
    '-'
  ),
  (
    126,
    'Pasta - Cannelloni, Sheets, Fresh',
    'mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis',
    86.27,
    5,
    '2021-01-20 00:00:00',
    3,
    '-'
  ),
  (
    127,
    'Apple - Macintosh',
    'volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus',
    19.96,
    45,
    '2021-01-07 00:00:00',
    6,
    '-'
  ),
  (
    128,
    'Vodka - Moskovskaya',
    'ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis',
    43.45,
    74,
    '2021-04-19 00:00:00',
    6,
    '-'
  ),
  (
    129,
    'Curry Powder',
    'vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum',
    32.31,
    42,
    '2021-01-30 00:00:00',
    4,
    '-'
  ),
  (
    130,
    'Sauce - Vodka Blush',
    'a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus',
    53.31,
    27,
    '2020-07-20 00:00:00',
    6,
    '-'
  ),
  (
    131,
    'Venison - Ground',
    'vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in',
    15.76,
    26,
    '2021-05-13 00:00:00',
    4,
    '-'
  ),
  (
    132,
    'Doilies - 8, Paper',
    'maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros',
    46.59,
    79,
    '2020-09-09 00:00:00',
    6,
    '-'
  ),
  (
    133,
    'Vaccum Bag - 14x20',
    'vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae',
    57.26,
    15,
    '2021-01-08 00:00:00',
    6,
    '-'
  ),
  (
    134,
    'Gherkin',
    'nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere',
    8.68,
    94,
    '2020-08-20 00:00:00',
    3,
    '-'
  ),
  (
    135,
    'Water - Mineral, Natural',
    'morbi odio odio elementum eu interdum eu tincidunt in leo',
    58.27,
    17,
    '2021-05-13 00:00:00',
    3,
    '-'
  ),
  (
    136,
    'Ecolab - Solid Fusion',
    'magna at nunc commodo placerat praesent blandit nam nulla integer',
    94.84,
    71,
    '2021-03-22 00:00:00',
    5,
    '-'
  ),
  (
    137,
    'Bar - Sweet And Salty Chocolate',
    'erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus',
    50.15,
    46,
    '2020-07-03 00:00:00',
    3,
    '-'
  ),
  (
    138,
    'Spice - Peppercorn Melange',
    'dapibus augue vel accumsan tellus nisi eu orci mauris lacinia',
    86.52,
    58,
    '2020-12-29 00:00:00',
    4,
    '-'
  ),
  (
    139,
    'Chicken Breast Wing On',
    'fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet',
    42.81,
    31,
    '2020-06-21 00:00:00',
    5,
    '-'
  ),
  (
    140,
    'Sauce - Roasted Red Pepper',
    'pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium',
    39.14,
    35,
    '2021-01-13 00:00:00',
    5,
    '-'
  ),
  (
    141,
    'Mackerel Whole Fresh',
    'at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante',
    24.36,
    98,
    '2021-02-08 00:00:00',
    3,
    '-'
  ),
  (
    142,
    'Glass Clear 8 Oz',
    'in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu',
    4.34,
    97,
    '2020-08-11 00:00:00',
    6,
    '-'
  ),
  (
    143,
    'Soup - Campbells, Spinach Crm',
    'diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat',
    15.47,
    18,
    '2021-01-03 00:00:00',
    3,
    '-'
  ),
  (
    144,
    'Pork Salted Bellies',
    'morbi a ipsum integer a nibh in quis justo maecenas rhoncus',
    61.50,
    50,
    '2021-04-14 00:00:00',
    6,
    '-'
  ),
  (
    145,
    'Juice - Pineapple, 48 Oz',
    'accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in',
    73.24,
    31,
    '2020-09-08 00:00:00',
    4,
    '-'
  ),
  (
    146,
    'Cheese - Comtomme',
    'fermentum justo nec condimentum neque sapien placerat ante nulla justo',
    20.58,
    65,
    '2020-11-27 00:00:00',
    6,
    '-'
  ),
  (
    147,
    'Cookie Dough - Peanut Butter',
    'consequat nulla nisl nunc nisl duis bibendum felis sed interdum',
    49.25,
    71,
    '2020-07-14 00:00:00',
    5,
    '-'
  ),
  (
    148,
    'Paste - Black Olive',
    'sit amet justo morbi ut odio cras mi pede malesuada',
    55.51,
    49,
    '2020-10-17 00:00:00',
    3,
    '-'
  ),
  (
    149,
    'Lettuce - Treviso',
    'malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor',
    56.29,
    92,
    '2020-08-21 00:00:00',
    3,
    '-'
  ),
  (
    150,
    'Tea - Lemon Green Tea',
    'commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id',
    70.09,
    10,
    '2020-09-16 00:00:00',
    3,
    '-'
  ),
  (
    151,
    'Lettuce - Curly Endive',
    'maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien',
    60.41,
    27,
    '2021-04-19 00:00:00',
    5,
    '-'
  ),
  (
    152,
    'Vinegar - Balsamic',
    'eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis',
    8.40,
    15,
    '2020-07-17 00:00:00',
    6,
    '-'
  ),
  (
    153,
    'Cheese - Brie Roitelet',
    'in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus',
    80.45,
    69,
    '2021-06-07 00:00:00',
    4,
    '-'
  ),
  (
    154,
    'Tomatoes - Diced, Canned',
    'justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum',
    47.43,
    41,
    '2020-07-31 00:00:00',
    4,
    '-'
  ),
  (
    155,
    'Muffin Mix - Morning Glory',
    'tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis',
    62.77,
    56,
    '2020-09-05 00:00:00',
    3,
    '-'
  ),
  (
    156,
    'Yogurt - Cherry, 175 Gr',
    'mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in',
    27.78,
    86,
    '2020-08-18 00:00:00',
    6,
    '-'
  ),
  (
    157,
    'Food Colouring - Green',
    'dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus',
    69.86,
    29,
    '2020-09-25 00:00:00',
    4,
    '-'
  ),
  (
    158,
    'Eel Fresh',
    'primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus',
    40.25,
    28,
    '2021-02-06 00:00:00',
    5,
    '-'
  ),
  (
    159,
    'Lemonade - Strawberry, 591 Ml',
    'justo in hac habitasse platea dictumst etiam faucibus cursus urna',
    7.04,
    7,
    '2020-10-02 00:00:00',
    6,
    '-'
  ),
  (
    160,
    'Cod - Salted, Boneless',
    'magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien',
    37.31,
    91,
    '2021-01-25 00:00:00',
    4,
    '-'
  ),
  (
    161,
    'Jam - Strawberry, 20 Ml Jar',
    'elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy',
    25.74,
    10,
    '2020-08-10 00:00:00',
    3,
    '-'
  ),
  (
    162,
    'Veal - Inside Round / Top, Lean',
    'ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et',
    72.51,
    85,
    '2021-05-19 00:00:00',
    6,
    '-'
  ),
  (
    163,
    'Lemonade - Pineapple Passion',
    'nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique',
    14.67,
    8,
    '2021-04-23 00:00:00',
    3,
    '-'
  ),
  (
    164,
    'Peach - Fresh',
    'non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi',
    74.71,
    51,
    '2021-06-08 00:00:00',
    5,
    '-'
  ),
  (
    165,
    'Garlic',
    'nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id',
    85.06,
    64,
    '2021-01-18 00:00:00',
    4,
    '-'
  ),
  (
    166,
    'Artichoke - Fresh',
    'pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing',
    70.35,
    100,
    '2020-09-27 00:00:00',
    6,
    '-'
  ),
  (
    167,
    'Sauce - Thousand Island',
    'orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis',
    35.45,
    64,
    '2021-03-02 00:00:00',
    3,
    '-'
  ),
  (
    168,
    'Sparkling Wine - Rose, Freixenet',
    'augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed',
    73.38,
    45,
    '2020-11-28 00:00:00',
    4,
    '-'
  ),
  (
    169,
    'Cheese - Cheddar, Medium',
    'tempus sit amet sem fusce consequat nulla nisl nunc nisl duis',
    80.33,
    95,
    '2020-11-09 00:00:00',
    3,
    '-'
  ),
  (
    170,
    'Yeast Dry - Fleischman',
    'adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien',
    46.37,
    39,
    '2020-06-17 00:00:00',
    4,
    '-'
  ),
  (
    171,
    'Chips - Potato Jalapeno',
    'augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis',
    30.96,
    9,
    '2021-03-07 00:00:00',
    4,
    '-'
  ),
  (
    172,
    'Shallots',
    'sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante',
    84.84,
    87,
    '2021-02-25 00:00:00',
    4,
    '-'
  ),
  (
    173,
    'Coke - Diet, 355 Ml',
    'eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis',
    89.46,
    52,
    '2020-07-20 00:00:00',
    3,
    '-'
  ),
  (
    174,
    'Pernod',
    'condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est',
    68.59,
    78,
    '2021-05-24 00:00:00',
    5,
    '-'
  ),
  (
    175,
    'Pate - Cognac',
    'eu est congue elementum in hac habitasse platea dictumst morbi',
    87.37,
    3,
    '2021-05-06 00:00:00',
    6,
    '-'
  ),
  (
    176,
    'Wine - Penfolds Koonuga Hill',
    'vestibulum sit amet cursus id turpis integer aliquet massa id',
    43.99,
    34,
    '2020-08-03 00:00:00',
    5,
    '-'
  ),
  (
    177,
    'Shrimp - Tiger 21/25',
    'massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat',
    59.91,
    4,
    '2020-07-23 00:00:00',
    3,
    '-'
  ),
  (
    178,
    'Watercress',
    'blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia',
    25.40,
    94,
    '2021-04-14 00:00:00',
    4,
    '-'
  ),
  (
    179,
    'Flour - Chickpea',
    'nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum',
    11.58,
    20,
    '2021-05-25 00:00:00',
    6,
    '-'
  ),
  (
    180,
    'Tea Leaves - Oolong',
    'varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia',
    9.86,
    92,
    '2021-03-14 00:00:00',
    4,
    '-'
  ),
  (
    181,
    'Wine - Hardys Bankside Shiraz',
    'vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc',
    98.46,
    69,
    '2020-12-29 00:00:00',
    3,
    '-'
  ),
  (
    182,
    'Magnotta - Bel Paese White',
    'mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit',
    87.08,
    65,
    '2021-04-24 00:00:00',
    5,
    '-'
  ),
  (
    183,
    'Beef - Montreal Smoked Brisket',
    'vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia',
    65.66,
    68,
    '2021-02-25 00:00:00',
    5,
    '-'
  ),
  (
    184,
    'Doilies - 7, Paper',
    'nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in',
    6.42,
    9,
    '2021-05-09 00:00:00',
    4,
    '-'
  ),
  (
    185,
    'Venison - Striploin',
    'vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis',
    85.15,
    88,
    '2021-02-20 00:00:00',
    6,
    '-'
  ),
  (
    186,
    'Turnip - Mini',
    'ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque',
    80.88,
    67,
    '2021-02-06 00:00:00',
    6,
    '-'
  ),
  (
    187,
    'Peach - Halves',
    'non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus',
    12.87,
    76,
    '2021-01-01 00:00:00',
    3,
    '-'
  ),
  (
    188,
    'Glaze - Clear',
    'quam a odio in hac habitasse platea dictumst maecenas ut massa',
    19.86,
    1,
    '2020-11-12 00:00:00',
    3,
    '-'
  ),
  (
    189,
    'Wine - Red, Concha Y Toro',
    'tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus',
    65.45,
    24,
    '2020-11-01 00:00:00',
    5,
    '-'
  ),
  (
    190,
    'Wine - Ej Gallo Sonoma',
    'parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor',
    91.58,
    6,
    '2021-02-17 00:00:00',
    4,
    '-'
  ),
  (
    191,
    'Pickles - Gherkins',
    'lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis',
    68.10,
    18,
    '2020-12-12 00:00:00',
    3,
    '-'
  ),
  (
    192,
    'Butter Sweet',
    'fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu',
    39.80,
    72,
    '2020-10-04 00:00:00',
    6,
    '-'
  ),
  (
    193,
    'Onions - Red Pearl',
    'magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer',
    35.52,
    51,
    '2021-05-31 00:00:00',
    3,
    '-'
  ),
  (
    194,
    'Seedlings - Mix, Organic',
    'aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris',
    6.23,
    51,
    '2020-11-29 00:00:00',
    5,
    '-'
  ),
  (
    195,
    'Bread - Calabrese Baguette',
    'enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue',
    80.51,
    43,
    '2020-07-18 00:00:00',
    3,
    '-'
  ),
  (
    196,
    'Lamb - Loin Chops',
    'libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan',
    94.45,
    2,
    '2020-08-07 00:00:00',
    5,
    '-'
  ),
  (
    197,
    'Peas Snow',
    'egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend',
    18.05,
    93,
    '2021-06-07 00:00:00',
    5,
    '-'
  ),
  (
    198,
    'Blueberries',
    'a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante',
    74.23,
    11,
    '2021-06-06 00:00:00',
    5,
    '-'
  ),
  (
    199,
    'Cookie - Dough Variety',
    'parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id',
    37.39,
    79,
    '2021-04-17 00:00:00',
    4,
    '-'
  ),
  (
    200,
    'Extract - Almond',
    'nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien',
    9.97,
    86,
    '2021-02-14 00:00:00',
    5,
    '-'
  ),
  (
    201,
    'Pastry - Banana Muffin - Mini',
    'convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante',
    34.27,
    98,
    '2021-03-05 00:00:00',
    4,
    '-'
  ),
  (
    202,
    'Food Colouring - Orange',
    'quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec',
    74.11,
    20,
    '2021-01-31 00:00:00',
    5,
    '-'
  ),
  (
    203,
    'Split Peas - Green, Dry',
    'lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec',
    2.51,
    77,
    '2020-08-02 00:00:00',
    4,
    '-'
  ),
  (
    204,
    'Lid Coffee Cup 8oz Blk',
    'mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt',
    26.97,
    71,
    '2020-08-27 00:00:00',
    3,
    '-'
  ),
  (
    205,
    'Truffle Cups Green',
    'proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum',
    88.95,
    38,
    '2021-01-20 00:00:00',
    3,
    '-'
  ),
  (
    206,
    'Cheese - Sheep Milk',
    'risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in',
    64.43,
    87,
    '2020-11-21 00:00:00',
    3,
    '-'
  ),
  (
    207,
    'Oil - Shortening - All - Purpose',
    'ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere',
    68.52,
    78,
    '2021-06-09 00:00:00',
    6,
    '-'
  ),
  (
    208,
    'Pepper - Chillies, Crushed',
    'ultrices aliquet maecenas leo odio condimentum id luctus nec molestie',
    17.08,
    77,
    '2020-11-08 00:00:00',
    5,
    '-'
  ),
  (
    209,
    'Chicken - Whole Roasting',
    'duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede',
    95.44,
    9,
    '2021-05-06 00:00:00',
    5,
    '-'
  ),
  (
    210,
    'Wiberg Cure',
    'vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis',
    52.18,
    6,
    '2021-04-09 00:00:00',
    6,
    '-'
  ),
  (
    211,
    'Cleaner - Lime Away',
    'ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui',
    78.25,
    95,
    '2020-09-06 00:00:00',
    6,
    '-'
  ),
  (
    212,
    'Puree - Kiwi',
    'ac tellus semper interdum mauris ullamcorper purus sit amet nulla',
    49.93,
    80,
    '2020-09-11 00:00:00',
    4,
    '-'
  ),
  (
    213,
    'Pineapple - Canned, Rings',
    'ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi',
    19.07,
    23,
    '2020-07-19 00:00:00',
    3,
    '-'
  ),
  (
    214,
    'Turkey - Oven Roast Breast',
    'adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in',
    85.71,
    10,
    '2021-03-31 00:00:00',
    3,
    '-'
  ),
  (
    215,
    'Hand Towel',
    'suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl',
    36.16,
    54,
    '2020-09-25 00:00:00',
    4,
    '-'
  ),
  (
    216,
    'Pork - Sausage, Medium',
    'vitae quam suspendisse potenti nullam porttitor lacus at turpis donec',
    68.06,
    25,
    '2020-10-31 00:00:00',
    3,
    '-'
  ),
  (
    217,
    'Cheese Cloth No 100',
    'id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia',
    11.95,
    52,
    '2020-12-31 00:00:00',
    3,
    '-'
  ),
  (
    218,
    'Sobe - Tropical Energy',
    'purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient',
    24.26,
    34,
    '2021-04-07 00:00:00',
    6,
    '-'
  ),
  (
    219,
    'Beef - Rib Roast, Capless',
    'accumsan felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec',
    85.39,
    41,
    '2020-10-28 00:00:00',
    5,
    '-'
  ),
  (
    220,
    'Beans - Turtle, Black, Dry',
    'turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec',
    40.72,
    30,
    '2020-09-23 00:00:00',
    6,
    '-'
  ),
  (
    221,
    'Cookie - Oatmeal',
    'vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec',
    55.05,
    33,
    '2021-03-08 00:00:00',
    4,
    '-'
  ),
  (
    222,
    'Lettuce - Escarole',
    'donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac',
    94.97,
    46,
    '2020-11-13 00:00:00',
    5,
    '-'
  ),
  (
    223,
    'Bread - Bistro White',
    'scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor',
    36.65,
    30,
    '2021-04-14 00:00:00',
    3,
    '-'
  ),
  (
    224,
    'English Muffin',
    'sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices',
    99.65,
    46,
    '2021-05-24 00:00:00',
    6,
    '-'
  ),
  (
    225,
    'Table Cloth 54x54 White',
    'ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue',
    37.58,
    54,
    '2021-03-19 00:00:00',
    3,
    '-'
  ),
  (
    226,
    'Melon - Watermelon, Seedless',
    'sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar',
    57.44,
    26,
    '2021-05-15 00:00:00',
    3,
    '-'
  ),
  (
    227,
    'Dill Weed - Dry',
    'nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit',
    99.51,
    40,
    '2020-10-26 00:00:00',
    3,
    '-'
  ),
  (
    228,
    'Pepper Squash',
    'pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum',
    11.07,
    45,
    '2021-02-14 00:00:00',
    5,
    '-'
  ),
  (
    229,
    'Flavouring - Orange',
    'elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis',
    6.83,
    95,
    '2021-04-06 00:00:00',
    5,
    '-'
  ),
  (
    230,
    'Spice - Peppercorn Melange',
    'felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices',
    56.29,
    49,
    '2021-05-13 00:00:00',
    5,
    '-'
  ),
  (
    231,
    'Sprouts - Onion',
    'augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat',
    5.68,
    67,
    '2021-01-14 00:00:00',
    4,
    '-'
  ),
  (
    232,
    'Wine - Magnotta - Cab Franc',
    'lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit',
    52.31,
    50,
    '2020-11-21 00:00:00',
    4,
    '-'
  ),
  (
    233,
    'Cup - 6oz, Foam',
    'imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in',
    92.28,
    97,
    '2021-04-02 00:00:00',
    6,
    '-'
  ),
  (
    234,
    'Cake - Dulce De Leche',
    'dui vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet',
    6.62,
    54,
    '2021-02-01 00:00:00',
    3,
    '-'
  ),
  (
    235,
    'Greens Mustard',
    'dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel',
    67.25,
    74,
    '2020-11-28 00:00:00',
    3,
    '-'
  ),
  (
    236,
    'Kiwano',
    'volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in',
    27.60,
    13,
    '2020-10-22 00:00:00',
    6,
    '-'
  ),
  (
    237,
    'Carbonated Water - Wildberry',
    'vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla',
    54.57,
    22,
    '2020-12-24 00:00:00',
    6,
    '-'
  ),
  (
    238,
    'Cheese - St. Paulin',
    'convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut',
    23.35,
    98,
    '2020-08-11 00:00:00',
    3,
    '-'
  ),
  (
    239,
    'Wine - Jaboulet Cotes Du Rhone',
    'eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat',
    14.43,
    48,
    '2020-07-13 00:00:00',
    5,
    '-'
  ),
  (
    240,
    'Pie Box - Cello Window 2.5',
    'ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit',
    46.42,
    94,
    '2021-03-30 00:00:00',
    4,
    '-'
  ),
  (
    241,
    'Brandy - Bar',
    'pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue',
    72.33,
    96,
    '2020-09-08 00:00:00',
    4,
    '-'
  ),
  (
    242,
    'Veal - Slab Bacon',
    'ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna',
    74.61,
    69,
    '2020-11-07 00:00:00',
    3,
    '-'
  ),
  (
    243,
    'Duck - Whole',
    'orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin',
    25.38,
    73,
    '2021-05-16 00:00:00',
    4,
    '-'
  ),
  (
    244,
    'Bagelers',
    'id pretium iaculis diam erat fermentum justo nec condimentum neque sapien',
    57.79,
    92,
    '2020-08-28 00:00:00',
    4,
    '-'
  ),
  (
    245,
    'Pepper - Pablano',
    'porttitor lacus at turpis donec posuere metus vitae ipsum aliquam',
    62.55,
    71,
    '2021-04-19 00:00:00',
    6,
    '-'
  ),
  (
    246,
    'Mustard - Seed',
    'ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit',
    88.31,
    65,
    '2021-02-08 00:00:00',
    4,
    '-'
  ),
  (
    247,
    'Strawberries',
    'libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum',
    43.48,
    97,
    '2020-11-12 00:00:00',
    3,
    '-'
  ),
  (
    248,
    'Cup - Translucent 7 Oz Clear',
    'dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla',
    54.28,
    78,
    '2021-02-11 00:00:00',
    6,
    '-'
  ),
  (
    249,
    'Jameson Irish Whiskey',
    'bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis',
    52.91,
    54,
    '2021-02-17 00:00:00',
    4,
    '-'
  ),
  (
    250,
    'Beef - Eye Of Round',
    'magna at nunc commodo placerat praesent blandit nam nulla integer pede justo',
    48.84,
    7,
    '2020-10-22 00:00:00',
    3,
    '-'
  ),
  (
    251,
    'The Pop Shoppe - Grape',
    'mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate',
    18.35,
    5,
    '2021-04-01 00:00:00',
    6,
    '-'
  ),
  (
    252,
    'Cheese - Cheddar, Medium',
    'enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis',
    92.34,
    85,
    '2020-06-10 00:00:00',
    3,
    '-'
  ),
  (
    253,
    'Tomatoes Tear Drop Yellow',
    'pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis',
    10.60,
    0,
    '2021-02-08 00:00:00',
    3,
    '-'
  ),
  (
    254,
    'Extract Vanilla Pure',
    'mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh',
    10.05,
    87,
    '2021-01-22 00:00:00',
    6,
    '-'
  ),
  (
    255,
    'Ham - Smoked, Bone - In',
    'vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia',
    83.75,
    93,
    '2020-12-29 00:00:00',
    3,
    '-'
  ),
  (
    256,
    'Burger Veggie',
    'vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at',
    53.73,
    44,
    '2020-10-09 00:00:00',
    3,
    '-'
  ),
  (
    257,
    'Appetizer - Sausage Rolls',
    'at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id',
    96.43,
    84,
    '2021-01-14 00:00:00',
    5,
    '-'
  ),
  (
    258,
    'Wine - Magnotta - Pinot Gris Sr',
    'nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris',
    26.42,
    2,
    '2021-02-17 00:00:00',
    4,
    '-'
  ),
  (
    259,
    'Melon - Watermelon Yellow',
    'sit amet justo morbi ut odio cras mi pede malesuada in',
    60.34,
    15,
    '2021-04-09 00:00:00',
    6,
    '-'
  ),
  (
    260,
    'Cheese - Brie, Triple Creme',
    'tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim',
    17.75,
    88,
    '2021-05-25 00:00:00',
    4,
    '-'
  ),
  (
    261,
    'Table Cloth 54x72 White',
    'turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget',
    44.88,
    48,
    '2020-07-07 00:00:00',
    4,
    '-'
  ),
  (
    262,
    'Chocolate Bar - Oh Henry',
    'in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu',
    67.60,
    99,
    '2020-07-16 00:00:00',
    5,
    '-'
  ),
  (
    263,
    'Cheese - Camembert',
    'semper porta volutpat quam pede lobortis ligula sit amet eleifend',
    23.20,
    27,
    '2021-01-20 00:00:00',
    5,
    '-'
  ),
  (
    264,
    'Soup - Campbells, Spinach Crm',
    'a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla',
    31.98,
    100,
    '2021-05-13 00:00:00',
    3,
    '-'
  ),
  (
    265,
    'Tea - Herbal Orange Spice',
    'a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla',
    80.89,
    86,
    '2021-03-03 00:00:00',
    5,
    '-'
  ),
  (
    266,
    'Berry Brulee',
    'praesent id massa id nisl venenatis lacinia aenean sit amet justo',
    37.42,
    5,
    '2021-05-21 00:00:00',
    4,
    '-'
  ),
  (
    267,
    'Bar - Sweet And Salty Chocolate',
    'orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi',
    22.84,
    26,
    '2020-12-21 00:00:00',
    5,
    '-'
  ),
  (
    268,
    'Gherkin',
    'at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes',
    57.02,
    86,
    '2021-04-16 00:00:00',
    4,
    '-'
  ),
  (
    269,
    'Lady Fingers',
    'vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet',
    75.55,
    59,
    '2020-08-07 00:00:00',
    5,
    '-'
  ),
  (
    270,
    'Beer - Upper Canada Light',
    'maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum',
    40.14,
    56,
    '2020-12-07 00:00:00',
    5,
    '-'
  ),
  (
    271,
    'Cocoa Powder - Dutched',
    'est congue elementum in hac habitasse platea dictumst morbi vestibulum velit',
    13.36,
    84,
    '2021-05-01 00:00:00',
    4,
    '-'
  ),
  (
    272,
    'Spice - Montreal Steak Spice',
    'morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus',
    45.15,
    81,
    '2020-11-29 00:00:00',
    5,
    '-'
  ),
  (
    273,
    'Jicama',
    'in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor',
    47.77,
    92,
    '2021-03-29 00:00:00',
    4,
    '-'
  ),
  (
    274,
    'Bar Mix - Lime',
    'sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper',
    49.72,
    80,
    '2020-10-10 00:00:00',
    6,
    '-'
  ),
  (
    275,
    'Macaroons - Two Bite Choc',
    'rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at',
    80.59,
    50,
    '2021-05-23 00:00:00',
    5,
    '-'
  ),
  (
    276,
    'Bandage - Fexible 1x3',
    'nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non',
    63.84,
    93,
    '2021-05-15 00:00:00',
    6,
    '-'
  ),
  (
    277,
    'V8 - Tropical Blend',
    'in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum',
    87.59,
    70,
    '2020-12-29 00:00:00',
    6,
    '-'
  ),
  (
    278,
    'Yoplait Drink',
    'tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non',
    59.28,
    16,
    '2020-08-03 00:00:00',
    4,
    '-'
  ),
  (
    279,
    'Sugar - Invert',
    'primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor',
    69.37,
    87,
    '2020-06-28 00:00:00',
    5,
    '-'
  ),
  (
    280,
    'Doilies - 10, Paper',
    'mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla',
    99.19,
    24,
    '2021-05-08 00:00:00',
    4,
    '-'
  ),
  (
    281,
    'Shrimp, Dried, Small / Lb',
    'in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec',
    24.32,
    34,
    '2020-08-29 00:00:00',
    3,
    '-'
  ),
  (
    282,
    'Vinegar - Tarragon',
    'auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio',
    16.87,
    63,
    '2021-05-17 00:00:00',
    5,
    '-'
  ),
  (
    283,
    'Cheese - La Sauvagine',
    'ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et',
    82.33,
    81,
    '2021-01-31 00:00:00',
    3,
    '-'
  ),
  (
    284,
    'Yucca',
    'erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam',
    14.26,
    67,
    '2020-10-19 00:00:00',
    4,
    '-'
  ),
  (
    285,
    'Beef - Shank',
    'at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra',
    18.74,
    25,
    '2020-11-03 00:00:00',
    4,
    '-'
  ),
  (
    286,
    'Potatoes - Mini White 3 Oz',
    'sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia',
    4.00,
    13,
    '2020-12-24 00:00:00',
    5,
    '-'
  ),
  (
    287,
    'Cup - 6oz, Foam',
    'sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus',
    2.83,
    38,
    '2021-01-11 00:00:00',
    5,
    '-'
  ),
  (
    288,
    'Allspice - Jamaican',
    'rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis',
    46.53,
    71,
    '2021-04-05 00:00:00',
    4,
    '-'
  ),
  (
    289,
    'Spice - Peppercorn Melange',
    'ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem',
    32.25,
    8,
    '2021-02-24 00:00:00',
    5,
    '-'
  ),
  (
    290,
    'Ham Black Forest',
    'a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie',
    2.97,
    68,
    '2020-12-13 00:00:00',
    6,
    '-'
  ),
  (
    291,
    'Chocolate - Chips Compound',
    'interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu est',
    10.59,
    95,
    '2020-08-11 00:00:00',
    5,
    '-'
  ),
  (
    292,
    'Lamb - Shanks',
    'accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum',
    85.78,
    91,
    '2021-05-30 00:00:00',
    3,
    '-'
  ),
  (
    293,
    'Wine - Chianti Classico Riserva',
    'cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum',
    42.08,
    82,
    '2021-01-20 00:00:00',
    6,
    '-'
  ),
  (
    294,
    'Coffee - Colombian, Portioned',
    'felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed',
    5.99,
    48,
    '2020-08-15 00:00:00',
    3,
    '-'
  ),
  (
    295,
    'Pasta - Fettuccine, Egg, Fresh',
    'sed accumsan felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis',
    12.85,
    16,
    '2020-06-12 00:00:00',
    6,
    '-'
  ),
  (
    296,
    'Tequila Rose Cream Liquor',
    'molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac',
    94.35,
    28,
    '2020-12-03 00:00:00',
    3,
    '-'
  ),
  (
    297,
    'Eggwhite Frozen',
    'faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat',
    64.40,
    80,
    '2021-02-24 00:00:00',
    5,
    '-'
  ),
  (
    298,
    'Pate - Liver',
    'sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc',
    87.14,
    86,
    '2021-03-26 00:00:00',
    4,
    '-'
  ),
  (
    299,
    'Thyme - Fresh',
    'lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis',
    13.95,
    80,
    '2020-10-30 00:00:00',
    5,
    '-'
  ),
  (
    300,
    'Ice Cream - Strawberry',
    'purus sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam nam',
    78.47,
    75,
    '2020-11-13 00:00:00',
    6,
    '-'
  ),
  (
    301,
    'Steampan - Lid For Half Size',
    'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam',
    29.54,
    95,
    '2020-07-30 00:00:00',
    4,
    '-'
  ),
  (
    302,
    'Oats Large Flake',
    'fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio',
    99.60,
    100,
    '2020-08-02 00:00:00',
    3,
    '-'
  ),
  (
    303,
    'Mcguinness - Blue Curacao',
    'convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim',
    30.76,
    42,
    '2020-08-22 00:00:00',
    5,
    '-'
  ),
  (
    304,
    'Sauce - Salsa',
    'a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum',
    82.29,
    24,
    '2020-12-09 00:00:00',
    5,
    '-'
  ),
  (
    305,
    'Frangelico',
    'ante ipsum primis in faucibus orci luctus et ultrices posuere',
    8.45,
    20,
    '2021-04-12 00:00:00',
    5,
    '-'
  ),
  (
    306,
    'Wine - Blue Nun Qualitatswein',
    'neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo',
    67.43,
    65,
    '2020-07-17 00:00:00',
    4,
    '-'
  ),
  (
    307,
    'Bread - Calabrese Baguette',
    'est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est',
    40.96,
    5,
    '2020-11-04 00:00:00',
    5,
    '-'
  ),
  (
    308,
    'Soup - Campbells',
    'nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet',
    70.29,
    81,
    '2021-05-08 00:00:00',
    4,
    '-'
  ),
  (
    309,
    'Doilies - 8, Paper',
    'pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo',
    49.70,
    80,
    '2021-04-30 00:00:00',
    4,
    '-'
  ),
  (
    310,
    'Taro Leaves',
    'diam cras pellentesque volutpat dui maecenas tristique est et tempus',
    64.75,
    87,
    '2020-12-12 00:00:00',
    5,
    '-'
  ),
  (
    311,
    'Tumeric',
    'volutpat erat quisque erat eros viverra eget congue eget semper rutrum',
    17.35,
    70,
    '2020-07-25 00:00:00',
    6,
    '-'
  ),
  (
    312,
    'Coconut - Creamed, Pure',
    'justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet',
    52.81,
    80,
    '2021-03-02 00:00:00',
    5,
    '-'
  ),
  (
    313,
    'Bread - Olive Dinner Roll',
    'ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor',
    88.96,
    61,
    '2021-02-12 00:00:00',
    3,
    '-'
  ),
  (
    314,
    'Wine - Fat Bastard Merlot',
    'nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer',
    73.55,
    14,
    '2020-12-04 00:00:00',
    3,
    '-'
  ),
  (
    315,
    'Beef - Tenderloin',
    'nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo',
    52.03,
    10,
    '2020-08-02 00:00:00',
    3,
    '-'
  ),
  (
    316,
    'Bread - White Epi Baguette',
    'morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu',
    2.21,
    48,
    '2021-05-03 00:00:00',
    6,
    '-'
  ),
  (
    317,
    'Soup - Campbells, Creamy',
    'hac habitasse platea dictumst maecenas ut massa quis augue luctus',
    14.16,
    67,
    '2020-10-20 00:00:00',
    3,
    '-'
  ),
  (
    318,
    'Dasheen',
    'donec dapibus duis at velit eu est congue elementum in hac habitasse',
    33.04,
    88,
    '2021-02-18 00:00:00',
    3,
    '-'
  ),
  (
    319,
    'Towel - Roll White',
    'mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci',
    36.51,
    11,
    '2021-01-30 00:00:00',
    6,
    '-'
  ),
  (
    320,
    'Juice - Orange 1.89l',
    'elit proin risus praesent lectus vestibulum quam sapien varius ut blandit',
    85.16,
    7,
    '2021-02-12 00:00:00',
    3,
    '-'
  ),
  (
    321,
    'Vermouth - White, Cinzano',
    'molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue',
    46.15,
    35,
    '2020-09-13 00:00:00',
    5,
    '-'
  ),
  (
    322,
    'Bread - French Baquette',
    'mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in hac',
    30.31,
    38,
    '2020-08-24 00:00:00',
    5,
    '-'
  ),
  (
    323,
    'Chinese Foods - Plain Fried Rice',
    'pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu',
    24.39,
    6,
    '2021-02-07 00:00:00',
    4,
    '-'
  ),
  (
    324,
    'Sausage - Chorizo',
    'magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis',
    72.17,
    62,
    '2021-03-31 00:00:00',
    6,
    '-'
  ),
  (
    325,
    'Lotus Root',
    'mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis',
    16.48,
    55,
    '2021-03-12 00:00:00',
    3,
    '-'
  ),
  (
    326,
    'Ecolab - Solid Fusion',
    'at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate',
    78.05,
    98,
    '2021-03-17 00:00:00',
    5,
    '-'
  ),
  (
    327,
    'Chicken - Thigh, Bone In',
    'nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu',
    61.95,
    100,
    '2020-08-15 00:00:00',
    6,
    '-'
  ),
  (
    328,
    'Pepper - Red Chili',
    'suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus',
    5.21,
    96,
    '2020-09-12 00:00:00',
    4,
    '-'
  ),
  (
    329,
    'Soup - Beef, Base Mix',
    'amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus',
    41.99,
    89,
    '2020-10-20 00:00:00',
    6,
    '-'
  ),
  (
    330,
    'Wine - Magnotta - Cab Franc',
    'ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam',
    13.21,
    43,
    '2021-05-16 00:00:00',
    6,
    '-'
  ),
  (
    331,
    'Red Currant Jelly',
    'at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat',
    44.53,
    95,
    '2020-07-08 00:00:00',
    6,
    '-'
  ),
  (
    332,
    'Soup - Knorr, Country Bean',
    'consequat metus sapien ut nunc vestibulum ante ipsum primis in',
    75.74,
    54,
    '2021-02-20 00:00:00',
    3,
    '-'
  ),
  (
    333,
    'Cafe Royale',
    'bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus',
    77.72,
    73,
    '2021-01-27 00:00:00',
    4,
    '-'
  ),
  (
    334,
    'Napkin White',
    'sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at',
    41.16,
    75,
    '2021-05-24 00:00:00',
    5,
    '-'
  ),
  (
    335,
    'Cheese - Provolone',
    'pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in',
    54.32,
    19,
    '2021-02-04 00:00:00',
    3,
    '-'
  ),
  (
    336,
    'Vermacelli - Sprinkles, Assorted',
    'id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at',
    33.79,
    46,
    '2020-06-10 00:00:00',
    6,
    '-'
  ),
  (
    337,
    'Creme De Cacao White',
    'condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales',
    30.59,
    29,
    '2020-10-29 00:00:00',
    5,
    '-'
  ),
  (
    338,
    'Mushroom - Lg - Cello',
    'nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum',
    29.11,
    29,
    '2021-05-23 00:00:00',
    4,
    '-'
  ),
  (
    339,
    'Assorted Desserts',
    'phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate',
    16.77,
    97,
    '2020-06-23 00:00:00',
    6,
    '-'
  ),
  (
    340,
    'Pork - Suckling Pig',
    'nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis',
    76.52,
    73,
    '2021-02-17 00:00:00',
    4,
    '-'
  ),
  (
    341,
    'Wine - Hardys Bankside Shiraz',
    'dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti',
    65.85,
    72,
    '2020-10-04 00:00:00',
    4,
    '-'
  ),
  (
    342,
    'Tart Shells - Savory, 3',
    'rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non',
    64.88,
    44,
    '2020-08-26 00:00:00',
    3,
    '-'
  ),
  (
    343,
    'Cheese - Gouda',
    'pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis',
    98.07,
    44,
    '2021-03-11 00:00:00',
    4,
    '-'
  ),
  (
    344,
    'Beef - Tenderloin - Aa',
    'ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque',
    36.69,
    9,
    '2020-11-28 00:00:00',
    4,
    '-'
  ),
  (
    345,
    'Pork - Ham, Virginia',
    'consequat morbi a ipsum integer a nibh in quis justo maecenas',
    58.53,
    79,
    '2021-03-01 00:00:00',
    6,
    '-'
  ),
  (
    346,
    'Lid Tray - 16in Dome',
    'accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean',
    30.96,
    32,
    '2021-01-29 00:00:00',
    6,
    '-'
  ),
  (
    347,
    'Beer - Corona',
    'morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices',
    93.68,
    84,
    '2020-06-14 00:00:00',
    5,
    '-'
  ),
  (
    348,
    'Milkettes - 2%',
    'dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non',
    86.05,
    64,
    '2020-09-23 00:00:00',
    3,
    '-'
  ),
  (
    349,
    'Five Alive Citrus',
    'orci pede venenatis non sodales sed tincidunt eu felis fusce',
    27.86,
    59,
    '2021-05-12 00:00:00',
    4,
    '-'
  ),
  (
    350,
    'Pasta - Canelloni, Single Serve',
    'nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum',
    20.21,
    19,
    '2020-08-27 00:00:00',
    5,
    '-'
  ),
  (
    351,
    'Juice - Cranberry 284ml',
    'placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede',
    13.05,
    56,
    '2021-05-11 00:00:00',
    5,
    '-'
  ),
  (
    352,
    'Wine - Vineland Estate Semi - Dry',
    'tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque',
    33.35,
    71,
    '2021-05-18 00:00:00',
    3,
    '-'
  ),
  (
    353,
    'Syrup - Monin - Passion Fruit',
    'non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum',
    64.58,
    56,
    '2020-09-25 00:00:00',
    5,
    '-'
  ),
  (
    354,
    'Marsala - Sperone, Fine, D.o.c.',
    'congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus',
    71.21,
    80,
    '2021-04-09 00:00:00',
    4,
    '-'
  ),
  (
    355,
    'Bowl 12 Oz - Showcase 92012',
    'quis lectus suspendisse potenti in eleifend quam a odio in',
    7.67,
    33,
    '2020-07-20 00:00:00',
    6,
    '-'
  ),
  (
    356,
    'Cod - Salted, Boneless',
    'est risus auctor sed tristique in tempus sit amet sem fusce consequat',
    26.71,
    12,
    '2020-07-28 00:00:00',
    5,
    '-'
  ),
  (
    357,
    'Lemonade - Kiwi, 591 Ml',
    'tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse',
    43.40,
    41,
    '2020-10-11 00:00:00',
    5,
    '-'
  ),
  (
    358,
    'Yeast Dry - Fleischman',
    'tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas',
    44.77,
    32,
    '2020-08-19 00:00:00',
    4,
    '-'
  ),
  (
    359,
    'Beef - Striploin',
    'sapien non mi integer ac neque duis bibendum morbi non quam nec dui luctus',
    77.01,
    95,
    '2021-05-13 00:00:00',
    4,
    '-'
  ),
  (
    360,
    'Plate Pie Foil',
    'lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse',
    6.97,
    84,
    '2020-08-05 00:00:00',
    5,
    '-'
  ),
  (
    361,
    'Madeira',
    'maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus',
    28.66,
    89,
    '2020-11-30 00:00:00',
    4,
    '-'
  ),
  (
    362,
    'Broccoli - Fresh',
    'morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus',
    84.58,
    93,
    '2020-11-20 00:00:00',
    4,
    '-'
  ),
  (
    363,
    'Wine - Rubyport',
    'turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu',
    98.70,
    92,
    '2020-08-10 00:00:00',
    4,
    '-'
  ),
  (
    364,
    'Bread Base - Italian',
    'lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi',
    19.74,
    28,
    '2021-06-03 00:00:00',
    6,
    '-'
  ),
  (
    365,
    'Flour - Corn, Fine',
    'curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer',
    32.55,
    68,
    '2021-04-02 00:00:00',
    5,
    '-'
  ),
  (
    366,
    'Bread Cranberry Foccacia',
    'nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed',
    95.08,
    76,
    '2020-10-24 00:00:00',
    3,
    '-'
  ),
  (
    367,
    'Lettuce - Boston Bib - Organic',
    'elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus',
    41.65,
    31,
    '2021-03-17 00:00:00',
    4,
    '-'
  ),
  (
    368,
    'Beef - Tenderlion, Center Cut',
    'quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus',
    3.45,
    36,
    '2020-09-08 00:00:00',
    5,
    '-'
  ),
  (
    369,
    'Squeeze Bottle',
    'consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices',
    75.90,
    17,
    '2020-12-27 00:00:00',
    5,
    '-'
  ),
  (
    370,
    'Muffin - Zero Transfat',
    'quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at',
    15.91,
    65,
    '2020-07-21 00:00:00',
    6,
    '-'
  ),
  (
    371,
    'Worcestershire Sauce',
    'cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus',
    45.93,
    61,
    '2020-12-06 00:00:00',
    5,
    '-'
  ),
  (
    372,
    'Lid Coffee Cup 8oz Blk',
    'sit amet erat nulla tempus vivamus in felis eu sapien cursus',
    52.14,
    21,
    '2021-02-18 00:00:00',
    3,
    '-'
  ),
  (
    373,
    'Yoplait Drink',
    'eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit',
    20.55,
    67,
    '2021-04-18 00:00:00',
    6,
    '-'
  ),
  (
    374,
    'Sausage - Liver',
    'lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi',
    58.67,
    39,
    '2020-10-20 00:00:00',
    4,
    '-'
  ),
  (
    375,
    'Snapple Lemon Tea',
    'interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie',
    42.45,
    43,
    '2020-11-02 00:00:00',
    4,
    '-'
  ),
  (
    376,
    'Salmon - Atlantic, No Skin',
    'dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus',
    38.85,
    15,
    '2020-10-31 00:00:00',
    3,
    '-'
  ),
  (
    377,
    'Black Currants',
    'accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean',
    76.68,
    63,
    '2020-09-21 00:00:00',
    4,
    '-'
  ),
  (
    378,
    'Food Colouring - Red',
    'rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum',
    52.70,
    87,
    '2020-08-17 00:00:00',
    4,
    '-'
  ),
  (
    379,
    'Chocolate - White',
    'id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit',
    1.92,
    69,
    '2021-04-02 00:00:00',
    4,
    '-'
  ),
  (
    380,
    'Calaloo',
    'urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat',
    8.55,
    76,
    '2020-08-03 00:00:00',
    5,
    '-'
  ),
  (
    381,
    'Cherries - Fresh',
    'nulla nunc purus phasellus in felis donec semper sapien a',
    31.41,
    45,
    '2020-09-04 00:00:00',
    3,
    '-'
  ),
  (
    382,
    'Muffin Orange Individual',
    'justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec',
    54.18,
    13,
    '2020-07-09 00:00:00',
    3,
    '-'
  ),
  (
    383,
    'Soup - French Can Pea',
    'sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla',
    76.57,
    85,
    '2021-04-17 00:00:00',
    4,
    '-'
  ),
  (
    384,
    'Nectarines',
    'arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis',
    11.16,
    30,
    '2020-10-26 00:00:00',
    4,
    '-'
  ),
  (
    385,
    'Shrimp - 21/25, Peel And Deviened',
    'lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat',
    68.55,
    65,
    '2020-11-14 00:00:00',
    5,
    '-'
  ),
  (
    386,
    'Salmon - Smoked, Sliced',
    'suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla',
    50.50,
    100,
    '2021-03-27 00:00:00',
    3,
    '-'
  ),
  (
    387,
    'Quail - Jumbo Boneless',
    'ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus',
    20.37,
    97,
    '2020-08-19 00:00:00',
    4,
    '-'
  ),
  (
    388,
    'Water - Spring Water, 355 Ml',
    'diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et',
    11.69,
    75,
    '2021-02-04 00:00:00',
    4,
    '-'
  ),
  (
    389,
    'Pastry - Choclate Baked',
    'purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat',
    70.65,
    11,
    '2020-12-27 00:00:00',
    3,
    '-'
  ),
  (
    390,
    'Banana Turning',
    'ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque',
    17.12,
    36,
    '2020-12-24 00:00:00',
    5,
    '-'
  ),
  (
    391,
    'Flavouring Vanilla Artificial',
    'sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor',
    9.47,
    59,
    '2021-01-21 00:00:00',
    3,
    '-'
  ),
  (
    392,
    'Lotus Rootlets - Canned',
    'pede justo lacinia eget tincidunt eget tempus vel pede morbi',
    72.76,
    8,
    '2021-05-06 00:00:00',
    5,
    '-'
  ),
  (
    393,
    'Filter - Coffee',
    'convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat',
    85.17,
    51,
    '2021-04-10 00:00:00',
    4,
    '-'
  ),
  (
    394,
    'Appetizer - Smoked Salmon / Dill',
    'pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate',
    32.16,
    11,
    '2020-11-08 00:00:00',
    5,
    '-'
  ),
  (
    395,
    'Macaroons - Two Bite Choc',
    'eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras',
    68.07,
    19,
    '2020-08-08 00:00:00',
    3,
    '-'
  ),
  (
    396,
    'Lamb - Bones',
    'pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing',
    36.67,
    24,
    '2021-05-13 00:00:00',
    6,
    '-'
  ),
  (
    397,
    'Mousse - Mango',
    'nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem',
    84.22,
    91,
    '2020-08-03 00:00:00',
    3,
    '-'
  ),
  (
    398,
    'Truffle Shells - Semi - Sweet',
    'maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien',
    72.09,
    19,
    '2020-08-17 00:00:00',
    5,
    '-'
  ),
  (
    399,
    'Pork - Tenderloin, Frozen',
    'eu felis fusce posuere felis sed lacus morbi sem mauris',
    52.90,
    8,
    '2020-10-29 00:00:00',
    4,
    '-'
  ),
  (
    400,
    'Chilli Paste, Ginger Garlic',
    'hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam',
    50.47,
    3,
    '2021-03-12 00:00:00',
    3,
    '-'
  ),
  (
    401,
    'Creme De Menth - White',
    'in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec',
    23.97,
    49,
    '2021-01-05 00:00:00',
    5,
    '-'
  ),
  (
    402,
    'Thyme - Dried',
    'semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis',
    85.99,
    96,
    '2020-11-26 00:00:00',
    4,
    '-'
  ),
  (
    403,
    'Pasta - Lasagna, Dry',
    'eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien',
    37.80,
    49,
    '2020-11-12 00:00:00',
    4,
    '-'
  ),
  (
    404,
    'Eggplant Italian',
    'lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque',
    80.68,
    52,
    '2021-05-13 00:00:00',
    5,
    '-'
  ),
  (
    405,
    'V8 - Vegetable Cocktail',
    'ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi',
    26.62,
    14,
    '2021-04-16 00:00:00',
    3,
    '-'
  ),
  (
    406,
    'Tray - 16in Rnd Blk',
    'nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit',
    20.69,
    46,
    '2021-04-09 00:00:00',
    6,
    '-'
  ),
  (
    407,
    'Juice Peach Nectar',
    'risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit',
    47.08,
    11,
    '2020-11-07 00:00:00',
    4,
    '-'
  ),
  (
    408,
    'Shrimp - Baby, Warm Water',
    'magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed',
    21.07,
    14,
    '2021-04-10 00:00:00',
    6,
    '-'
  ),
  (
    409,
    'Chicken - Whole Fryers',
    'ac lobortis vel dapibus at diam nam tristique tortor eu',
    60.39,
    59,
    '2020-09-25 00:00:00',
    6,
    '-'
  ),
  (
    410,
    'Gatorade - Orange',
    'ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia',
    98.40,
    58,
    '2020-11-18 00:00:00',
    5,
    '-'
  ),
  (
    411,
    'Fib N9 - Prague Powder',
    'morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus',
    53.53,
    91,
    '2020-11-21 00:00:00',
    5,
    '-'
  ),
  (
    412,
    'Mushroom - Enoki, Fresh',
    'adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at',
    39.73,
    44,
    '2021-03-23 00:00:00',
    5,
    '-'
  ),
  (
    413,
    'Sauce - Hp',
    'aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea',
    57.26,
    35,
    '2021-01-23 00:00:00',
    4,
    '-'
  ),
  (
    414,
    'Beer - Paulaner Hefeweisse',
    'duis consequat dui nec nisi volutpat eleifend donec ut dolor',
    95.30,
    68,
    '2020-12-15 00:00:00',
    3,
    '-'
  ),
  (
    415,
    'Nut - Pecan, Halves',
    'fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus',
    81.11,
    48,
    '2021-05-16 00:00:00',
    4,
    '-'
  ),
  (
    416,
    'Vodka - Smirnoff',
    'proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis',
    24.05,
    62,
    '2020-08-07 00:00:00',
    3,
    '-'
  ),
  (
    417,
    'Wine - Port Late Bottled Vintage',
    'suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla',
    27.91,
    95,
    '2021-04-25 00:00:00',
    6,
    '-'
  ),
  (
    418,
    'Kiwi Gold Zespri',
    'id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget',
    28.83,
    92,
    '2020-12-31 00:00:00',
    3,
    '-'
  ),
  (
    419,
    'Soup - Chicken And Wild Rice',
    'primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui',
    74.76,
    96,
    '2020-12-04 00:00:00',
    5,
    '-'
  ),
  (
    420,
    'Cream Of Tartar',
    'suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum',
    4.22,
    42,
    '2021-02-15 00:00:00',
    3,
    '-'
  ),
  (
    421,
    'Pasta - Cheese / Spinach Bauletti',
    'lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare',
    81.91,
    12,
    '2020-10-23 00:00:00',
    3,
    '-'
  ),
  (
    422,
    'Yucca',
    'augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis',
    7.39,
    34,
    '2020-09-13 00:00:00',
    4,
    '-'
  ),
  (
    423,
    'Zucchini - Yellow',
    'in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis',
    55.25,
    83,
    '2020-07-31 00:00:00',
    6,
    '-'
  ),
  (
    424,
    'Transfer Sheets',
    'ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus',
    91.43,
    95,
    '2021-01-26 00:00:00',
    6,
    '-'
  ),
  (
    425,
    'Beef - Cooked, Corned',
    'ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit',
    24.65,
    65,
    '2021-01-02 00:00:00',
    6,
    '-'
  ),
  (
    426,
    'Bar Bran Honey Nut',
    'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla',
    68.49,
    30,
    '2021-04-14 00:00:00',
    6,
    '-'
  ),
  (
    427,
    'Quail - Whole, Bone - In',
    'eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare',
    41.85,
    30,
    '2021-01-11 00:00:00',
    6,
    '-'
  ),
  (
    428,
    'Pepper - Julienne, Frozen',
    'tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus',
    22.56,
    65,
    '2021-05-14 00:00:00',
    5,
    '-'
  ),
  (
    429,
    'Radish - Pickled',
    'mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel',
    91.52,
    79,
    '2020-12-09 00:00:00',
    5,
    '-'
  ),
  (
    430,
    'Chocolate Eclairs',
    'dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam',
    75.55,
    30,
    '2021-05-11 00:00:00',
    5,
    '-'
  ),
  (
    431,
    'Godiva White Chocolate',
    'velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis',
    36.17,
    73,
    '2020-09-08 00:00:00',
    5,
    '-'
  ),
  (
    432,
    'Sauce - Soya, Light',
    'congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien',
    81.10,
    48,
    '2021-04-24 00:00:00',
    6,
    '-'
  ),
  (
    433,
    'Sherry - Dry',
    'natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue',
    78.54,
    9,
    '2020-12-18 00:00:00',
    5,
    '-'
  ),
  (
    434,
    'Potatoes - Peeled',
    'at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam',
    82.59,
    76,
    '2021-02-02 00:00:00',
    6,
    '-'
  ),
  (
    435,
    'Wine - Two Oceans Cabernet',
    'nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum',
    33.55,
    86,
    '2020-10-16 00:00:00',
    4,
    '-'
  ),
  (
    436,
    'Appetizer - Southwestern',
    'amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor',
    38.94,
    77,
    '2021-04-27 00:00:00',
    4,
    '-'
  ),
  (
    437,
    'Wine - Penfolds Koonuga Hill',
    'luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus',
    50.05,
    11,
    '2021-01-22 00:00:00',
    5,
    '-'
  ),
  (
    438,
    'Appetizer - Shrimp Puff',
    'viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum',
    65.45,
    30,
    '2020-12-04 00:00:00',
    4,
    '-'
  ),
  (
    439,
    'Isomalt',
    'sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum',
    33.57,
    93,
    '2020-09-06 00:00:00',
    5,
    '-'
  ),
  (
    440,
    'Beans - Soya Bean',
    'id turpis integer aliquet massa id lobortis convallis tortor risus',
    88.40,
    29,
    '2021-05-20 00:00:00',
    4,
    '-'
  ),
  (
    441,
    'Beef - Shank',
    'volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea',
    58.80,
    99,
    '2020-10-19 00:00:00',
    3,
    '-'
  ),
  (
    442,
    'Oil - Shortening - All - Purpose',
    'congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec',
    15.47,
    51,
    '2021-01-27 00:00:00',
    3,
    '-'
  ),
  (
    443,
    'Pepper - Chilli Seeds Mild',
    'nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla',
    39.69,
    35,
    '2020-10-03 00:00:00',
    6,
    '-'
  ),
  (
    444,
    'Pasta - Fusili, Dry',
    'pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante',
    17.95,
    19,
    '2020-11-17 00:00:00',
    3,
    '-'
  ),
  (
    445,
    'Flower - Leather Leaf Fern',
    'bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem',
    69.96,
    83,
    '2021-01-24 00:00:00',
    5,
    '-'
  ),
  (
    446,
    'Black Currants',
    'lacus purus aliquet at feugiat non pretium quis lectus suspendisse',
    8.73,
    8,
    '2020-07-28 00:00:00',
    6,
    '-'
  ),
  (
    447,
    'Sword Pick Asst',
    'ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi',
    32.29,
    16,
    '2021-01-21 00:00:00',
    5,
    '-'
  ),
  (
    448,
    'Soup - Campbells, Lentil',
    'nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam',
    48.58,
    76,
    '2021-01-27 00:00:00',
    5,
    '-'
  ),
  (
    449,
    'Roe - Lump Fish, Red',
    'non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam',
    84.19,
    65,
    '2021-04-04 00:00:00',
    4,
    '-'
  ),
  (
    450,
    'Sauce - Demi Glace',
    'ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa',
    81.03,
    90,
    '2020-09-09 00:00:00',
    4,
    '-'
  ),
  (
    451,
    'Coffee Cup 8oz 5338cd',
    'vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl',
    73.11,
    71,
    '2021-02-15 00:00:00',
    6,
    '-'
  ),
  (
    452,
    'Salmon - Smoked, Sliced',
    'rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi',
    30.55,
    11,
    '2020-10-09 00:00:00',
    4,
    '-'
  ),
  (
    453,
    'Veal - Osso Bucco',
    'ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo',
    93.75,
    23,
    '2020-10-31 00:00:00',
    4,
    '-'
  ),
  (
    454,
    'Sole - Dover, Whole, Fresh',
    'nunc donec quis orci eget orci vehicula condimentum curabitur in libero',
    14.14,
    29,
    '2021-06-05 00:00:00',
    6,
    '-'
  ),
  (
    455,
    'Vaccum Bag - 14x20',
    'libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed',
    56.18,
    92,
    '2021-03-26 00:00:00',
    3,
    '-'
  ),
  (
    456,
    'Sausage - Liver',
    'adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis',
    87.44,
    25,
    '2020-08-01 00:00:00',
    6,
    '-'
  ),
  (
    457,
    'Wine - Magnotta, White',
    'diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien',
    96.03,
    34,
    '2021-01-30 00:00:00',
    5,
    '-'
  ),
  (
    458,
    'Ham - Virginia',
    'hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem',
    93.87,
    87,
    '2021-04-08 00:00:00',
    4,
    '-'
  ),
  (
    459,
    'Onion - Dried',
    'semper porta volutpat quam pede lobortis ligula sit amet eleifend',
    5.80,
    5,
    '2020-09-24 00:00:00',
    4,
    '-'
  ),
  (
    460,
    'Coffee - Decafenated',
    'mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam',
    35.38,
    32,
    '2020-09-29 00:00:00',
    3,
    '-'
  ),
  (
    461,
    'Sauce - Plum',
    'platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam',
    8.77,
    35,
    '2020-07-03 00:00:00',
    4,
    '-'
  ),
  (
    462,
    'Yogurt - Raspberry, 175 Gr',
    'habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque',
    74.58,
    100,
    '2020-12-08 00:00:00',
    4,
    '-'
  ),
  (
    463,
    'Orange - Tangerine',
    'ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra',
    91.78,
    85,
    '2020-06-19 00:00:00',
    5,
    '-'
  ),
  (
    464,
    'Chicken - Soup Base',
    'nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula',
    11.88,
    55,
    '2020-08-20 00:00:00',
    4,
    '-'
  ),
  (
    465,
    'Ecolab - Lime - A - Way 4/4 L',
    'nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum',
    88.85,
    93,
    '2021-05-27 00:00:00',
    3,
    '-'
  ),
  (
    466,
    'Cheese - Parmigiano Reggiano',
    'morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non',
    77.72,
    82,
    '2020-08-17 00:00:00',
    3,
    '-'
  ),
  (
    467,
    'Beef - Chuck, Boneless',
    'viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec',
    85.88,
    22,
    '2020-10-21 00:00:00',
    5,
    '-'
  ),
  (
    468,
    'Raisin - Golden',
    'duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim',
    94.29,
    51,
    '2020-12-04 00:00:00',
    4,
    '-'
  ),
  (
    469,
    'Molasses - Fancy',
    'ut odio cras mi pede malesuada in imperdiet et commodo vulputate',
    1.13,
    8,
    '2021-02-25 00:00:00',
    3,
    '-'
  ),
  (
    470,
    'Pork - Ground',
    'vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus',
    96.62,
    34,
    '2020-07-19 00:00:00',
    6,
    '-'
  ),
  (
    471,
    'Bread - White, Unsliced',
    'donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna',
    83.52,
    51,
    '2021-01-17 00:00:00',
    4,
    '-'
  ),
  (
    472,
    'Versatainer Nc - 8288',
    'dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia',
    23.04,
    81,
    '2020-07-13 00:00:00',
    5,
    '-'
  ),
  (
    473,
    'Lambcasing',
    'nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in',
    78.97,
    70,
    '2020-06-16 00:00:00',
    6,
    '-'
  ),
  (
    474,
    'Beef - Ox Tongue',
    'augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat',
    27.92,
    79,
    '2020-11-05 00:00:00',
    4,
    '-'
  ),
  (
    475,
    'Pepper - Green, Chili',
    'eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in',
    95.20,
    61,
    '2021-01-13 00:00:00',
    6,
    '-'
  ),
  (
    476,
    'Beer - Tetleys',
    'dapibus augue vel accumsan tellus nisi eu orci mauris lacinia',
    34.41,
    16,
    '2020-12-14 00:00:00',
    3,
    '-'
  ),
  (
    477,
    'Yogurt - Cherry, 175 Gr',
    'phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut',
    52.89,
    80,
    '2020-08-05 00:00:00',
    3,
    '-'
  ),
  (
    478,
    'Sole - Fillet',
    'interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu',
    28.28,
    35,
    '2021-04-26 00:00:00',
    5,
    '-'
  ),
  (
    479,
    'Turnip - White, Organic',
    'sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam nam tristique',
    50.07,
    25,
    '2021-02-09 00:00:00',
    5,
    '-'
  ),
  (
    480,
    'Dip - Tapenade',
    'tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium',
    45.11,
    41,
    '2020-08-11 00:00:00',
    6,
    '-'
  ),
  (
    481,
    'Coffee - 10oz Cup 92961',
    'maecenas tincidunt lacus at velit vivamus vel nulla eget eros',
    21.42,
    93,
    '2021-05-01 00:00:00',
    4,
    '-'
  ),
  (
    482,
    'Pasta - Elbows, Macaroni, Dry',
    'faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus',
    37.30,
    87,
    '2021-04-08 00:00:00',
    6,
    '-'
  ),
  (
    483,
    'Wine - White, Colubia Cresh',
    'lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a',
    1.59,
    42,
    '2020-06-24 00:00:00',
    4,
    '-'
  ),
  (
    484,
    'Soup - Beef Conomme, Dry',
    'ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec',
    92.54,
    75,
    '2021-01-05 00:00:00',
    4,
    '-'
  ),
  (
    485,
    'Soup - Campbells Mushroom',
    'eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus',
    32.67,
    17,
    '2020-09-27 00:00:00',
    4,
    '-'
  ),
  (
    486,
    'Potatoes - Mini Red',
    'purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in',
    57.24,
    21,
    '2021-03-14 00:00:00',
    5,
    '-'
  ),
  (
    487,
    'Cheese - Havarti, Salsa',
    'blandit non interdum in ante vestibulum ante ipsum primis in',
    31.03,
    75,
    '2020-12-06 00:00:00',
    6,
    '-'
  ),
  (
    488,
    'Shrimp - 21/25, Peel And Deviened',
    'sed tristique in tempus sit amet sem fusce consequat nulla',
    83.12,
    20,
    '2020-07-09 00:00:00',
    4,
    '-'
  ),
  (
    489,
    'Propel Sport Drink',
    'aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum',
    50.37,
    18,
    '2020-08-03 00:00:00',
    4,
    '-'
  ),
  (
    490,
    'Chicken - White Meat With Tender',
    'vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis',
    39.47,
    64,
    '2020-12-23 00:00:00',
    6,
    '-'
  ),
  (
    491,
    'Guinea Fowl',
    'erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis',
    84.54,
    43,
    '2020-11-04 00:00:00',
    5,
    '-'
  ),
  (
    492,
    'Bowl 12 Oz - Showcase 92012',
    'praesent blandit lacinia erat vestibulum sed magna at nunc commodo',
    29.71,
    13,
    '2021-02-04 00:00:00',
    4,
    '-'
  ),
  (
    493,
    'Yeast Dry - Fermipan',
    'libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo',
    10.79,
    86,
    '2021-05-11 00:00:00',
    3,
    '-'
  ),
  (
    494,
    'Mushroom - Chantrelle, Fresh',
    'amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras',
    23.61,
    39,
    '2020-09-12 00:00:00',
    5,
    '-'
  ),
  (
    495,
    'Beer - Steamwhistle',
    'sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit',
    7.39,
    82,
    '2021-03-12 00:00:00',
    4,
    '-'
  ),
  (
    496,
    'Lettuce - Belgian Endive',
    'libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate',
    40.96,
    59,
    '2020-09-30 00:00:00',
    3,
    '-'
  ),
  (
    497,
    'Jello - Assorted',
    'in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu',
    13.53,
    97,
    '2021-02-22 00:00:00',
    5,
    '-'
  ),
  (
    498,
    'Garlic Powder',
    'morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec',
    2.19,
    3,
    '2020-08-27 00:00:00',
    6,
    '-'
  ),
  (
    499,
    'Pickle - Dill',
    'sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam',
    31.52,
    77,
    '2020-09-20 00:00:00',
    6,
    '-'
  ),
  (
    500,
    'Flour Dark Rye',
    'at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel',
    37.41,
    75,
    '2020-10-22 00:00:00',
    5,
    '-'
  ),
  (
    501,
    'Compound - Pear',
    'potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus',
    93.42,
    51,
    '2021-06-07 00:00:00',
    6,
    '-'
  ),
  (
    502,
    'Cookie Chocolate Chip With',
    'libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet',
    66.30,
    29,
    '2020-07-25 00:00:00',
    3,
    '-'
  ),
  (
    503,
    'Cloves - Ground',
    'nulla nunc purus phasellus in felis donec semper sapien a libero',
    26.06,
    15,
    '2020-11-08 00:00:00',
    5,
    '-'
  ),
  (
    504,
    'Sauce - Thousand Island',
    'congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a',
    60.11,
    46,
    '2020-09-27 00:00:00',
    4,
    '-'
  ),
  (
    505,
    'Yogurt - Assorted Pack',
    'suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum',
    12.44,
    67,
    '2020-07-25 00:00:00',
    3,
    '-'
  ),
  (
    506,
    'Dooleys Toffee',
    'hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla',
    71.19,
    52,
    '2021-05-26 00:00:00',
    6,
    '-'
  ),
  (
    507,
    'Marzipan 50/50',
    'felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus',
    89.05,
    58,
    '2021-03-25 00:00:00',
    3,
    '-'
  ),
  (
    508,
    'Flavouring - Raspberry',
    'tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est',
    72.89,
    40,
    '2021-02-28 00:00:00',
    6,
    '-'
  ),
  (
    509,
    'Lamb - Bones',
    'aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa',
    1.44,
    80,
    '2021-04-09 00:00:00',
    5,
    '-'
  ),
  (
    510,
    'Pineapple - Canned, Rings',
    'aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed',
    14.96,
    77,
    '2021-04-04 00:00:00',
    3,
    '-'
  ),
  (
    511,
    'Chicken - Whole Roasting',
    'sagittis nam congue risus semper porta volutpat quam pede lobortis ligula',
    54.87,
    44,
    '2021-02-10 00:00:00',
    4,
    '-'
  ),
  (
    512,
    'Scallops - U - 10',
    'blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae',
    88.21,
    100,
    '2021-04-25 00:00:00',
    4,
    '-'
  ),
  (
    513,
    'Container - Clear 32 Oz',
    'quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea',
    5.78,
    30,
    '2021-03-04 00:00:00',
    6,
    '-'
  ),
  (
    514,
    'Juice - Orange 1.89l',
    'eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis',
    54.45,
    65,
    '2020-10-04 00:00:00',
    4,
    '-'
  ),
  (
    515,
    'Sparkling Wine - Rose, Freixenet',
    'justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue',
    95.18,
    44,
    '2020-12-24 00:00:00',
    3,
    '-'
  ),
  (
    516,
    'Sultanas',
    'maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum',
    48.75,
    64,
    '2020-08-27 00:00:00',
    3,
    '-'
  ),
  (
    517,
    'Pasta - Cheese / Spinach Bauletti',
    'primis in faucibus orci luctus et ultrices posuere cubilia curae donec',
    93.85,
    21,
    '2021-03-28 00:00:00',
    4,
    '-'
  ),
  (
    518,
    'Tart - Pecan Butter Squares',
    'ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin',
    4.75,
    43,
    '2021-04-23 00:00:00',
    4,
    '-'
  ),
  (
    519,
    'Tarts Assorted',
    'pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla',
    68.34,
    87,
    '2021-04-21 00:00:00',
    6,
    '-'
  ),
  (
    520,
    'Appetizer - Asian Shrimp Roll',
    'massa id lobortis convallis tortor risus dapibus augue vel accumsan',
    92.58,
    47,
    '2021-03-15 00:00:00',
    6,
    '-'
  ),
  (
    521,
    'Pork - Smoked Back Bacon',
    'primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin',
    14.00,
    1,
    '2021-05-13 00:00:00',
    5,
    '-'
  ),
  (
    522,
    'Vodka - Smirnoff',
    'justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in',
    66.15,
    38,
    '2020-09-15 00:00:00',
    4,
    '-'
  ),
  (
    523,
    'Cake - Miini Cheesecake Cherry',
    'potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non',
    57.35,
    37,
    '2020-11-19 00:00:00',
    6,
    '-'
  ),
  (
    524,
    'Tia Maria',
    'dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam',
    57.76,
    82,
    '2021-01-29 00:00:00',
    6,
    '-'
  ),
  (
    525,
    'Banana Turning',
    'augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum',
    90.39,
    64,
    '2020-07-10 00:00:00',
    6,
    '-'
  ),
  (
    526,
    'Rice - Brown',
    'eget vulputate ut ultrices vel augue vestibulum ante ipsum primis',
    57.03,
    54,
    '2020-10-04 00:00:00',
    5,
    '-'
  ),
  (
    527,
    'Potatoes - Fingerling 4 Oz',
    'commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem',
    32.99,
    89,
    '2021-02-07 00:00:00',
    6,
    '-'
  ),
  (
    528,
    'Shrimp - Tiger 21/25',
    'fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris',
    79.68,
    71,
    '2021-03-27 00:00:00',
    6,
    '-'
  ),
  (
    529,
    'Lamb - Shanks',
    'proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus',
    17.39,
    29,
    '2020-07-01 00:00:00',
    6,
    '-'
  ),
  (
    530,
    'Wine - Red, Cabernet Merlot',
    'platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum',
    89.73,
    57,
    '2020-12-11 00:00:00',
    4,
    '-'
  ),
  (
    531,
    'Bread - Sour Batard',
    'mauris non ligula pellentesque ultrices phasellus id sapien in sapien',
    57.33,
    6,
    '2021-05-04 00:00:00',
    3,
    '-'
  ),
  (
    532,
    'Ginger - Crystalized',
    'turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a',
    8.17,
    88,
    '2020-08-25 00:00:00',
    3,
    '-'
  ),
  (
    533,
    'Eggplant - Asian',
    'lectus in est risus auctor sed tristique in tempus sit amet sem',
    50.50,
    69,
    '2020-12-26 00:00:00',
    3,
    '-'
  ),
  (
    534,
    'Wine - Malbec Trapiche Reserve',
    'dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst',
    90.41,
    61,
    '2020-11-10 00:00:00',
    5,
    '-'
  ),
  (
    535,
    'Coffee Cup 16oz Foam',
    'justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus',
    2.94,
    82,
    '2021-02-04 00:00:00',
    6,
    '-'
  ),
  (
    536,
    'Coconut Milk - Unsweetened',
    'ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam',
    66.22,
    90,
    '2020-11-09 00:00:00',
    6,
    '-'
  ),
  (
    537,
    'Squid Ink',
    'suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam',
    32.21,
    65,
    '2020-06-20 00:00:00',
    3,
    '-'
  ),
  (
    538,
    'Wine - Bouchard La Vignee Pinot',
    'habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum',
    90.55,
    70,
    '2020-06-24 00:00:00',
    6,
    '-'
  ),
  (
    539,
    'Guinea Fowl',
    'nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque',
    4.85,
    97,
    '2020-08-02 00:00:00',
    3,
    '-'
  ),
  (
    540,
    'Remy Red',
    'justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate',
    67.10,
    41,
    '2021-04-05 00:00:00',
    6,
    '-'
  ),
  (
    541,
    'Cookie Dough - Chocolate Chip',
    'erat fermentum justo nec condimentum neque sapien placerat ante nulla justo',
    16.48,
    11,
    '2020-09-09 00:00:00',
    3,
    '-'
  ),
  (
    542,
    'Fennel',
    'non ligula pellentesque ultrices phasellus id sapien in sapien iaculis',
    2.73,
    15,
    '2021-01-15 00:00:00',
    4,
    '-'
  ),
  (
    543,
    'Nacho Chips',
    'massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh',
    57.42,
    97,
    '2021-04-09 00:00:00',
    6,
    '-'
  ),
  (
    544,
    'Sugar - Invert',
    'eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes',
    23.54,
    77,
    '2020-12-25 00:00:00',
    6,
    '-'
  ),
  (
    545,
    'Tarts Assorted',
    'vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna',
    79.79,
    51,
    '2020-11-02 00:00:00',
    3,
    '-'
  ),
  (
    546,
    'Mushroom Morel Fresh',
    'in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla',
    27.00,
    52,
    '2020-10-21 00:00:00',
    3,
    '-'
  ),
  (
    547,
    'Hersey Shakes',
    'sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis',
    47.61,
    23,
    '2020-12-19 00:00:00',
    6,
    '-'
  ),
  (
    548,
    'Tomatoes - Heirloom',
    'semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin',
    74.60,
    84,
    '2021-01-14 00:00:00',
    5,
    '-'
  ),
  (
    549,
    'Tea - Herbal Orange Spice',
    'vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in',
    68.15,
    1,
    '2021-04-13 00:00:00',
    3,
    '-'
  ),
  (
    550,
    'Pork - Bacon Cooked Slcd',
    'nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus',
    2.24,
    94,
    '2020-09-04 00:00:00',
    6,
    '-'
  ),
  (
    551,
    'Mint - Fresh',
    'rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue',
    84.18,
    45,
    '2020-10-01 00:00:00',
    5,
    '-'
  ),
  (
    552,
    'Bread - Bistro Sour',
    'nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer',
    99.35,
    69,
    '2021-01-13 00:00:00',
    3,
    '-'
  ),
  (
    553,
    'Wine - Magnotta - Red, Baco',
    'vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices',
    27.60,
    71,
    '2021-02-14 00:00:00',
    5,
    '-'
  ),
  (
    554,
    'Chicken - Leg, Fresh',
    'leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam',
    11.50,
    2,
    '2021-06-02 00:00:00',
    4,
    '-'
  ),
  (
    555,
    'Soup - French Onion, Dry',
    'libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc',
    66.46,
    37,
    '2021-01-24 00:00:00',
    6,
    '-'
  ),
  (
    556,
    'Sachet',
    'faucibus cursus urna ut tellus nulla ut erat id mauris',
    74.35,
    81,
    '2021-03-21 00:00:00',
    3,
    '-'
  ),
  (
    557,
    'Carrots - Purple, Organic',
    'eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis',
    12.34,
    48,
    '2021-06-02 00:00:00',
    5,
    '-'
  ),
  (
    558,
    'Yogurt - Raspberry, 175 Gr',
    'sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet',
    73.13,
    32,
    '2021-05-07 00:00:00',
    6,
    '-'
  ),
  (
    559,
    'Chocolate - Chips Compound',
    'consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim',
    91.36,
    13,
    '2020-11-17 00:00:00',
    4,
    '-'
  ),
  (
    560,
    'Sponge Cake Mix - Chocolate',
    'aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam pede',
    77.66,
    75,
    '2020-07-28 00:00:00',
    4,
    '-'
  ),
  (
    561,
    'Flower - Potmums',
    'justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id',
    62.42,
    82,
    '2020-09-22 00:00:00',
    5,
    '-'
  ),
  (
    562,
    'Glass Clear 7 Oz Xl',
    'sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus',
    97.10,
    97,
    '2020-11-03 00:00:00',
    4,
    '-'
  ),
  (
    563,
    'Flour - Strong Pizza',
    'justo morbi ut odio cras mi pede malesuada in imperdiet et commodo',
    2.22,
    15,
    '2020-08-01 00:00:00',
    6,
    '-'
  ),
  (
    564,
    'Glass Clear 7 Oz Xl',
    'tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit',
    45.75,
    85,
    '2020-09-28 00:00:00',
    5,
    '-'
  ),
  (
    565,
    'Taro Leaves',
    'rutrum nulla nunc purus phasellus in felis donec semper sapien a libero',
    56.91,
    58,
    '2020-12-01 00:00:00',
    3,
    '-'
  ),
  (
    566,
    'Bread Bowl Plain',
    'eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et',
    11.53,
    77,
    '2021-04-04 00:00:00',
    5,
    '-'
  ),
  (
    567,
    'Cheese - Cambozola',
    'nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend',
    52.08,
    44,
    '2020-07-02 00:00:00',
    6,
    '-'
  ),
  (
    568,
    'Lettuce - Spring Mix',
    'dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla',
    14.24,
    50,
    '2020-08-29 00:00:00',
    5,
    '-'
  ),
  (
    569,
    'Crab - Claws, 26 - 30',
    'congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero',
    60.21,
    78,
    '2021-02-22 00:00:00',
    3,
    '-'
  ),
  (
    570,
    'Stock - Chicken, White',
    'velit eu est congue elementum in hac habitasse platea dictumst',
    48.55,
    24,
    '2021-04-15 00:00:00',
    6,
    '-'
  ),
  (
    571,
    'Latex Rubber Gloves Size 9',
    'proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum',
    1.13,
    44,
    '2021-01-19 00:00:00',
    3,
    '-'
  ),
  (
    572,
    'Wine - White Cab Sauv.on',
    'amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in',
    34.66,
    27,
    '2020-12-06 00:00:00',
    6,
    '-'
  ),
  (
    573,
    'Cheese - Brie, Cups 125g',
    'nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur',
    36.30,
    32,
    '2020-06-12 00:00:00',
    5,
    '-'
  ),
  (
    574,
    'Flour - All Purpose',
    'faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam',
    5.11,
    41,
    '2021-03-28 00:00:00',
    4,
    '-'
  ),
  (
    575,
    'Lemon Balm - Fresh',
    'quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio',
    24.68,
    64,
    '2021-04-24 00:00:00',
    3,
    '-'
  ),
  (
    576,
    'Tomatoes - Roma',
    'congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium',
    10.38,
    89,
    '2020-07-05 00:00:00',
    4,
    '-'
  ),
  (
    577,
    'Soup - Campbells, Classic Chix',
    'eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem',
    24.59,
    48,
    '2020-12-10 00:00:00',
    5,
    '-'
  ),
  (
    578,
    'Beer - Upper Canada Light',
    'erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper',
    98.21,
    66,
    '2020-10-11 00:00:00',
    4,
    '-'
  ),
  (
    579,
    'Hersey Shakes',
    'at nulla suspendisse potenti cras in purus eu magna vulputate luctus',
    79.61,
    74,
    '2020-09-16 00:00:00',
    5,
    '-'
  ),
  (
    580,
    'Extract - Rum',
    'lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in',
    23.37,
    62,
    '2021-03-02 00:00:00',
    3,
    '-'
  ),
  (
    581,
    'Yams',
    'elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum',
    12.88,
    40,
    '2020-10-05 00:00:00',
    4,
    '-'
  ),
  (
    582,
    'Water - Spring 1.5lit',
    'vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan',
    99.96,
    49,
    '2021-03-18 00:00:00',
    4,
    '-'
  ),
  (
    583,
    'Skirt - 24 Foot',
    'eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis',
    92.67,
    7,
    '2021-03-20 00:00:00',
    5,
    '-'
  ),
  (
    584,
    'Flour Dark Rye',
    'nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in',
    52.70,
    69,
    '2020-08-17 00:00:00',
    6,
    '-'
  ),
  (
    585,
    'Coffee - Almond Amaretto',
    'lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna',
    97.09,
    82,
    '2020-09-17 00:00:00',
    4,
    '-'
  ),
  (
    586,
    'Bread - Rolls, Rye',
    'erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi',
    80.76,
    76,
    '2021-02-01 00:00:00',
    4,
    '-'
  ),
  (
    587,
    'Salmon - Fillets',
    'euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis',
    68.90,
    8,
    '2021-03-12 00:00:00',
    3,
    '-'
  ),
  (
    588,
    'Cheese - Brick With Onion',
    'nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla',
    52.21,
    63,
    '2020-07-31 00:00:00',
    6,
    '-'
  ),
  (
    589,
    'Tray - 16in Rnd Blk',
    'libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis',
    32.03,
    89,
    '2021-04-15 00:00:00',
    5,
    '-'
  ),
  (
    590,
    'Pike - Frozen Fillet',
    'consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede',
    6.97,
    5,
    '2021-01-12 00:00:00',
    3,
    '-'
  ),
  (
    591,
    'Kirsch - Schloss',
    'dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat',
    42.90,
    44,
    '2021-03-09 00:00:00',
    6,
    '-'
  ),
  (
    592,
    'Ham - Procutinni',
    'ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor',
    41.48,
    56,
    '2020-08-29 00:00:00',
    5,
    '-'
  ),
  (
    593,
    'Lettuce - Curly Endive',
    'lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit',
    2.38,
    74,
    '2020-10-14 00:00:00',
    4,
    '-'
  ),
  (
    594,
    'Black Currants',
    'morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus',
    17.39,
    52,
    '2021-05-24 00:00:00',
    6,
    '-'
  ),
  (
    595,
    'Doilies - 5, Paper',
    'vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi',
    1.06,
    86,
    '2020-07-15 00:00:00',
    6,
    '-'
  ),
  (
    596,
    'Gelatine Powder',
    'congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat',
    60.24,
    100,
    '2020-08-11 00:00:00',
    6,
    '-'
  ),
  (
    597,
    'Noodles - Steamed Chow Mein',
    'venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed',
    10.56,
    49,
    '2021-03-02 00:00:00',
    5,
    '-'
  ),
  (
    598,
    'Yogurt - Raspberry, 175 Gr',
    'mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel',
    9.79,
    35,
    '2020-09-23 00:00:00',
    4,
    '-'
  ),
  (
    599,
    'Tarts Assorted',
    'neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus',
    84.04,
    27,
    '2020-09-04 00:00:00',
    4,
    '-'
  ),
  (
    600,
    'Icecream - Dstk Super Cone',
    'pede lobortis ligula sit amet eleifend pede libero quis orci',
    50.84,
    96,
    '2020-11-30 00:00:00',
    3,
    '-'
  ),
  (
    601,
    'Wine - Rhine Riesling Wolf Blass',
    'ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue',
    11.87,
    17,
    '2021-04-27 00:00:00',
    3,
    '-'
  ),
  (
    602,
    'Beans - Fine',
    'sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla',
    54.25,
    84,
    '2021-01-09 00:00:00',
    4,
    '-'
  ),
  (
    603,
    'Wine - Cousino Macul Antiguas',
    'purus sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus',
    33.22,
    48,
    '2020-12-12 00:00:00',
    4,
    '-'
  ),
  (
    604,
    'Appetizer - Sausage Rolls',
    'luctus et ultrices posuere cubilia curae mauris viverra diam vitae',
    91.63,
    13,
    '2020-06-18 00:00:00',
    6,
    '-'
  ),
  (
    605,
    'Russian Prince',
    'donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam',
    72.46,
    49,
    '2020-08-25 00:00:00',
    6,
    '-'
  ),
  (
    606,
    'Cabbage - Nappa',
    'quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae',
    74.35,
    2,
    '2021-04-13 00:00:00',
    4,
    '-'
  ),
  (
    607,
    'Syrup - Monin - Passion Fruit',
    'quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec',
    14.17,
    55,
    '2020-06-10 00:00:00',
    4,
    '-'
  ),
  (
    608,
    'Jack Daniels',
    'vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla',
    63.09,
    30,
    '2020-10-25 00:00:00',
    4,
    '-'
  ),
  (
    609,
    'Beef - Ground, Extra Lean, Fresh',
    'mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at',
    88.73,
    35,
    '2021-04-12 00:00:00',
    6,
    '-'
  ),
  (
    610,
    'Icecream - Dstk Cml And Fdg',
    'ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien',
    78.11,
    81,
    '2020-11-13 00:00:00',
    3,
    '-'
  ),
  (
    611,
    'Beer - Muskoka Cream Ale',
    'diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat',
    95.62,
    10,
    '2021-02-15 00:00:00',
    5,
    '-'
  ),
  (
    612,
    'Wine - Acient Coast Caberne',
    'massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia',
    86.89,
    7,
    '2020-10-04 00:00:00',
    6,
    '-'
  ),
  (
    613,
    'Shrimp - Baby, Warm Water',
    'nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi',
    37.16,
    33,
    '2020-07-26 00:00:00',
    5,
    '-'
  ),
  (
    614,
    'Quiche Assorted',
    'sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac',
    25.19,
    57,
    '2021-05-03 00:00:00',
    6,
    '-'
  ),
  (
    615,
    'Appetizer - Sausage Rolls',
    'rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan',
    93.60,
    94,
    '2021-04-02 00:00:00',
    4,
    '-'
  ),
  (
    616,
    'Ecolab - Ster Bac',
    'donec semper sapien a libero nam dui proin leo odio porttitor id consequat',
    93.16,
    79,
    '2020-12-05 00:00:00',
    6,
    '-'
  ),
  (
    617,
    'Olives - Black, Pitted',
    'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est',
    67.08,
    76,
    '2021-06-04 00:00:00',
    3,
    '-'
  ),
  (
    618,
    'Napkin - Beverge, White 2 - Ply',
    'non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu',
    73.73,
    36,
    '2020-11-27 00:00:00',
    4,
    '-'
  ),
  (
    619,
    'Wine - Charddonnay Errazuriz',
    'faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam',
    16.29,
    33,
    '2020-09-02 00:00:00',
    5,
    '-'
  ),
  (
    620,
    'Oil - Safflower',
    'orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel',
    7.67,
    95,
    '2021-06-08 00:00:00',
    4,
    '-'
  ),
  (
    621,
    'Bread - Dark Rye',
    'pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat',
    65.31,
    77,
    '2021-05-31 00:00:00',
    6,
    '-'
  ),
  (
    622,
    'Ginger - Ground',
    'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae',
    71.12,
    14,
    '2020-07-12 00:00:00',
    3,
    '-'
  ),
  (
    623,
    'Cucumber - English',
    'cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et',
    82.68,
    68,
    '2021-01-19 00:00:00',
    5,
    '-'
  ),
  (
    624,
    'Sterno - Chafing Dish Fuel',
    'mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus',
    52.77,
    48,
    '2021-01-20 00:00:00',
    4,
    '-'
  ),
  (
    625,
    'Soup - Knorr, Chicken Noodle',
    'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec',
    50.07,
    30,
    '2021-04-23 00:00:00',
    3,
    '-'
  ),
  (
    626,
    'Rum - Light, Captain Morgan',
    'tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non',
    90.20,
    52,
    '2020-11-17 00:00:00',
    5,
    '-'
  ),
  (
    627,
    'Wine - Zinfandel California 2002',
    'hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum',
    55.71,
    38,
    '2020-07-04 00:00:00',
    4,
    '-'
  ),
  (
    628,
    'Pasta - Linguini, Dry',
    'ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus',
    78.66,
    35,
    '2020-09-30 00:00:00',
    4,
    '-'
  ),
  (
    629,
    'Juice Peach Nectar',
    'elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper',
    25.05,
    66,
    '2020-06-21 00:00:00',
    3,
    '-'
  ),
  (
    630,
    'Beef - Roasted, Cooked',
    'eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper',
    81.59,
    13,
    '2021-02-13 00:00:00',
    4,
    '-'
  ),
  (
    631,
    'Icecream Cone - Areo Chocolate',
    'vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam',
    82.33,
    89,
    '2020-09-14 00:00:00',
    5,
    '-'
  ),
  (
    632,
    'Wine - Maipo Valle Cabernet',
    'eget nunc donec quis orci eget orci vehicula condimentum curabitur',
    16.52,
    92,
    '2020-06-14 00:00:00',
    3,
    '-'
  ),
  (
    633,
    'Lamb Rack Frenched Australian',
    'et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat',
    95.50,
    12,
    '2021-01-07 00:00:00',
    4,
    '-'
  ),
  (
    634,
    'Wine - Spumante Bambino White',
    'praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat',
    99.09,
    30,
    '2021-02-06 00:00:00',
    5,
    '-'
  ),
  (
    635,
    'Sauce - White, Mix',
    'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui',
    90.02,
    54,
    '2021-05-22 00:00:00',
    3,
    '-'
  ),
  (
    636,
    'Calypso - Black Cherry Lemonade',
    'nullam orci pede venenatis non sodales sed tincidunt eu felis fusce',
    28.12,
    42,
    '2021-01-12 00:00:00',
    5,
    '-'
  ),
  (
    637,
    'Flour - Strong Pizza',
    'rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor',
    10.05,
    85,
    '2021-04-15 00:00:00',
    6,
    '-'
  ),
  (
    638,
    'Ecolab - Hand Soap Form Antibac',
    'nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et',
    89.15,
    74,
    '2021-05-31 00:00:00',
    4,
    '-'
  ),
  (
    639,
    'Nori Sea Weed',
    'imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam',
    82.66,
    91,
    '2021-03-05 00:00:00',
    6,
    '-'
  ),
  (
    640,
    'Bread - Calabrese Baguette',
    'ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac',
    25.38,
    43,
    '2020-10-03 00:00:00',
    5,
    '-'
  ),
  (
    641,
    'Tea - Earl Grey',
    'nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere',
    95.08,
    31,
    '2020-09-13 00:00:00',
    3,
    '-'
  ),
  (
    642,
    'Capicola - Hot',
    'ac est lacinia nisi venenatis tristique fusce congue diam id',
    90.60,
    55,
    '2020-06-27 00:00:00',
    3,
    '-'
  ),
  (
    643,
    'Chinese Foods - Chicken',
    'sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut',
    4.77,
    76,
    '2020-12-19 00:00:00',
    6,
    '-'
  ),
  (
    644,
    'Bread - French Stick',
    'convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus',
    94.19,
    21,
    '2021-04-02 00:00:00',
    5,
    '-'
  ),
  (
    645,
    'Sprouts - Onion',
    'nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget',
    80.48,
    64,
    '2020-07-06 00:00:00',
    5,
    '-'
  ),
  (
    646,
    'Pastry - French Mini Assorted',
    'lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat',
    53.14,
    42,
    '2020-10-31 00:00:00',
    6,
    '-'
  ),
  (
    647,
    'Star Anise, Whole',
    'luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur',
    23.01,
    78,
    '2020-06-13 00:00:00',
    5,
    '-'
  ),
  (
    648,
    '7up Diet, 355 Ml',
    'tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est',
    79.07,
    82,
    '2020-07-16 00:00:00',
    5,
    '-'
  ),
  (
    649,
    'Rabbit - Saddles',
    'cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non',
    93.25,
    69,
    '2021-02-08 00:00:00',
    4,
    '-'
  ),
  (
    650,
    'Sour Puss - Tangerine',
    'cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris',
    40.35,
    89,
    '2021-01-11 00:00:00',
    6,
    '-'
  ),
  (
    651,
    'Potato - Sweet',
    'et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin',
    85.45,
    82,
    '2021-02-12 00:00:00',
    4,
    '-'
  ),
  (
    652,
    'Nantucket - Kiwi Berry Cktl.',
    'morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices',
    59.74,
    98,
    '2020-09-07 00:00:00',
    6,
    '-'
  ),
  (
    653,
    'Wine - Ej Gallo Sierra Valley',
    'nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis',
    28.12,
    21,
    '2021-02-16 00:00:00',
    5,
    '-'
  ),
  (
    654,
    'Onions - Red Pearl',
    'semper rutrum nulla nunc purus phasellus in felis donec semper sapien',
    2.23,
    93,
    '2021-05-01 00:00:00',
    5,
    '-'
  ),
  (
    655,
    'Soy Protein',
    'in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam',
    94.42,
    14,
    '2020-08-07 00:00:00',
    4,
    '-'
  ),
  (
    656,
    'Sauce - Marinara',
    'enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur',
    5.62,
    14,
    '2020-11-06 00:00:00',
    4,
    '-'
  ),
  (
    657,
    'Salt - Sea',
    'justo morbi ut odio cras mi pede malesuada in imperdiet',
    25.91,
    95,
    '2020-11-25 00:00:00',
    3,
    '-'
  ),
  (
    658,
    'Wine - Jafflin Bourgongone',
    'erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget',
    91.01,
    21,
    '2020-10-09 00:00:00',
    4,
    '-'
  ),
  (
    659,
    'Hot Choc Vending',
    'sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam nam',
    52.05,
    76,
    '2020-09-06 00:00:00',
    4,
    '-'
  ),
  (
    660,
    'Amaretto',
    'tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id',
    96.34,
    57,
    '2020-06-19 00:00:00',
    4,
    '-'
  ),
  (
    661,
    'Garlic - Primerba, Paste',
    'pede justo eu massa donec dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst morbi',
    16.36,
    31,
    '2020-09-19 00:00:00',
    4,
    '-'
  ),
  (
    662,
    'Ecolab Silver Fusion',
    'eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla',
    88.79,
    83,
    '2020-08-01 00:00:00',
    3,
    '-'
  ),
  (
    663,
    'Raisin - Golden',
    'nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam',
    58.76,
    97,
    '2020-08-25 00:00:00',
    5,
    '-'
  ),
  (
    664,
    'Lettuce - Sea / Sea Asparagus',
    'orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec',
    41.73,
    8,
    '2020-09-12 00:00:00',
    5,
    '-'
  ),
  (
    665,
    'Wine - Red, Gamay Noir',
    'tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat',
    6.72,
    23,
    '2020-06-18 00:00:00',
    3,
    '-'
  ),
  (
    666,
    'Coffee - Decafenated',
    'sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula',
    21.93,
    74,
    '2020-07-09 00:00:00',
    5,
    '-'
  ),
  (
    667,
    'Mix - Cocktail Strawberry Daiquiri',
    'pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis',
    52.74,
    53,
    '2021-06-08 00:00:00',
    6,
    '-'
  ),
  (
    668,
    'Carbonated Water - Strawberry',
    'cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque',
    40.86,
    44,
    '2021-05-27 00:00:00',
    3,
    '-'
  ),
  (
    669,
    'Pepper - Red Bell',
    'turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet',
    25.64,
    41,
    '2020-07-12 00:00:00',
    6,
    '-'
  ),
  (
    670,
    'Ham - Black Forest',
    'et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut',
    87.40,
    56,
    '2021-05-19 00:00:00',
    3,
    '-'
  ),
  (
    671,
    'Cakes Assorted',
    'et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis',
    31.81,
    79,
    '2020-08-03 00:00:00',
    5,
    '-'
  ),
  (
    672,
    'Wine - Domaine Boyar Royal',
    'congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam',
    25.10,
    31,
    '2021-05-23 00:00:00',
    3,
    '-'
  ),
  (
    673,
    'Cheese - Brie,danish',
    'elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper',
    91.06,
    42,
    '2020-12-13 00:00:00',
    6,
    '-'
  ),
  (
    674,
    'Bread - Kimel Stick Poly',
    'in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus',
    79.45,
    60,
    '2021-02-09 00:00:00',
    6,
    '-'
  ),
  (
    675,
    'Tomato - Green',
    'integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat',
    38.98,
    18,
    '2020-10-01 00:00:00',
    4,
    '-'
  ),
  (
    676,
    'Extract - Lemon',
    'suspendisse potenti in eleifend quam a odio in hac habitasse',
    78.16,
    5,
    '2021-05-04 00:00:00',
    6,
    '-'
  ),
  (
    677,
    'Tea - Orange Pekoe',
    'id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat',
    13.80,
    5,
    '2021-04-09 00:00:00',
    6,
    '-'
  ),
  (
    678,
    'Langers - Mango Nectar',
    'mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet',
    75.50,
    24,
    '2020-12-08 00:00:00',
    6,
    '-'
  ),
  (
    679,
    'Apple - Delicious, Red',
    'primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis',
    74.54,
    58,
    '2020-06-20 00:00:00',
    6,
    '-'
  ),
  (
    680,
    'Cleaner - Bleach',
    'duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam',
    59.18,
    88,
    '2021-04-28 00:00:00',
    5,
    '-'
  ),
  (
    681,
    'Spinach - Packaged',
    'tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus',
    24.33,
    13,
    '2021-06-06 00:00:00',
    3,
    '-'
  ),
  (
    682,
    'Bacardi Breezer - Strawberry',
    'in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie',
    37.22,
    97,
    '2021-05-29 00:00:00',
    6,
    '-'
  ),
  (
    683,
    'Sobe - Green Tea',
    'dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce',
    52.08,
    13,
    '2020-08-29 00:00:00',
    5,
    '-'
  ),
  (
    684,
    'Butter - Salted, Micro',
    'convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia',
    14.83,
    68,
    '2021-05-04 00:00:00',
    6,
    '-'
  ),
  (
    685,
    'Spic And Span All Purpose',
    'et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor',
    5.57,
    77,
    '2021-01-19 00:00:00',
    5,
    '-'
  ),
  (
    686,
    'Milkettes - 2%',
    'vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl',
    11.77,
    32,
    '2021-06-06 00:00:00',
    6,
    '-'
  ),
  (
    687,
    'Quail Eggs - Canned',
    'donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque',
    72.23,
    82,
    '2020-12-07 00:00:00',
    6,
    '-'
  ),
  (
    688,
    'Soap - Pine Sol Floor Cleaner',
    'quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices',
    97.73,
    0,
    '2021-04-12 00:00:00',
    4,
    '-'
  ),
  (
    689,
    'Pail - 15l White, With Handle',
    'praesent lectus vestibulum quam sapien varius ut blandit non interdum in',
    73.84,
    49,
    '2020-08-17 00:00:00',
    3,
    '-'
  ),
  (
    690,
    'Flounder - Fresh',
    'ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam',
    47.02,
    23,
    '2020-11-28 00:00:00',
    4,
    '-'
  ),
  (
    691,
    'Vol Au Vents',
    'congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a',
    25.05,
    52,
    '2020-06-11 00:00:00',
    3,
    '-'
  ),
  (
    692,
    'Tea - Honey Green Tea',
    'nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus',
    9.78,
    93,
    '2021-03-28 00:00:00',
    3,
    '-'
  ),
  (
    693,
    'Nectarines',
    'velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat',
    53.85,
    11,
    '2021-05-23 00:00:00',
    6,
    '-'
  ),
  (
    694,
    'Bagels Poppyseed',
    'id luctus nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et',
    77.76,
    52,
    '2020-07-28 00:00:00',
    5,
    '-'
  ),
  (
    695,
    'Table Cloth 53x69 White',
    'habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla',
    92.17,
    67,
    '2021-01-03 00:00:00',
    3,
    '-'
  ),
  (
    696,
    'Wine - Balbach Riverside',
    'purus phasellus in felis donec semper sapien a libero nam dui proin',
    45.95,
    47,
    '2020-10-24 00:00:00',
    4,
    '-'
  ),
  (
    697,
    'Bread Country Roll',
    'nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula',
    48.85,
    46,
    '2020-07-07 00:00:00',
    3,
    '-'
  ),
  (
    698,
    'Wine - Tio Pepe Sherry Fino',
    'odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam',
    58.48,
    75,
    '2020-11-02 00:00:00',
    5,
    '-'
  ),
  (
    699,
    'Curry Paste - Madras',
    'nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed',
    50.49,
    14,
    '2020-07-15 00:00:00',
    6,
    '-'
  ),
  (
    700,
    'Lime Cordial - Roses',
    'ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit',
    4.09,
    98,
    '2020-07-20 00:00:00',
    5,
    '-'
  ),
  (
    701,
    'Fish - Halibut, Cold Smoked',
    'congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed',
    4.66,
    44,
    '2020-11-18 00:00:00',
    4,
    '-'
  ),
  (
    702,
    'Veal - Ground',
    'ut nunc vestibulum ante ipsum primis in faucibus orci luctus et',
    61.72,
    36,
    '2020-09-10 00:00:00',
    5,
    '-'
  ),
  (
    703,
    'Marsala - Sperone, Fine, D.o.c.',
    'viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae',
    75.52,
    94,
    '2020-11-26 00:00:00',
    3,
    '-'
  ),
  (
    704,
    'Tabasco Sauce, 2 Oz',
    'praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget',
    47.85,
    76,
    '2020-12-17 00:00:00',
    3,
    '-'
  ),
  (
    705,
    'Uniform Linen Charge',
    'rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue',
    53.02,
    4,
    '2020-09-14 00:00:00',
    5,
    '-'
  ),
  (
    706,
    'Soup - Campbells Beef Noodle',
    'pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla',
    28.68,
    41,
    '2020-08-26 00:00:00',
    4,
    '-'
  ),
  (
    707,
    'Salmon - Atlantic, No Skin',
    'metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean',
    23.02,
    44,
    '2020-11-26 00:00:00',
    3,
    '-'
  ),
  (
    708,
    'Rice - Jasmine Sented',
    'dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh',
    5.20,
    58,
    '2020-09-15 00:00:00',
    6,
    '-'
  ),
  (
    709,
    'Wine La Vielle Ferme Cote Du',
    'rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa',
    23.11,
    28,
    '2020-11-02 00:00:00',
    6,
    '-'
  ),
  (
    710,
    'Juice - Apple, 341 Ml',
    'risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis',
    73.52,
    35,
    '2020-07-18 00:00:00',
    4,
    '-'
  ),
  (
    711,
    'Lemon Balm - Fresh',
    'pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus',
    66.85,
    68,
    '2020-09-04 00:00:00',
    6,
    '-'
  ),
  (
    712,
    'Garlic - Primerba, Paste',
    'sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec',
    22.25,
    89,
    '2020-07-08 00:00:00',
    5,
    '-'
  ),
  (
    713,
    'Chocolate - Milk, Callets',
    'sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel',
    15.33,
    75,
    '2020-07-17 00:00:00',
    6,
    '-'
  ),
  (
    714,
    'Dill Weed - Dry',
    'faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae',
    32.07,
    72,
    '2021-01-26 00:00:00',
    3,
    '-'
  ),
  (
    715,
    'Beef - Montreal Smoked Brisket',
    'elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing',
    68.72,
    7,
    '2020-11-05 00:00:00',
    5,
    '-'
  ),
  (
    716,
    'Vaccum Bag - 14x20',
    'erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus',
    41.39,
    17,
    '2021-04-13 00:00:00',
    6,
    '-'
  ),
  (
    717,
    'Soap - Mr.clean Floor Soap',
    'lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum',
    98.67,
    4,
    '2020-07-29 00:00:00',
    6,
    '-'
  ),
  (
    718,
    'Sauce - Apple, Unsweetened',
    'mauris vulputate elementum nullam varius nulla facilisi cras non velit',
    35.30,
    12,
    '2020-12-27 00:00:00',
    4,
    '-'
  ),
  (
    719,
    'Crush - Grape, 355 Ml',
    'nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac',
    2.04,
    49,
    '2020-12-14 00:00:00',
    4,
    '-'
  ),
  (
    720,
    'Cornstarch',
    'vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum',
    58.32,
    4,
    '2020-08-26 00:00:00',
    3,
    '-'
  ),
  (
    721,
    'Dip - Tapenade',
    'platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at',
    81.86,
    91,
    '2021-02-22 00:00:00',
    6,
    '-'
  ),
  (
    722,
    'Chicken - Livers',
    'in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus',
    19.45,
    44,
    '2021-03-26 00:00:00',
    4,
    '-'
  ),
  (
    723,
    'Wine - Casillero Deldiablo',
    'quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus',
    30.36,
    17,
    '2021-04-06 00:00:00',
    4,
    '-'
  ),
  (
    724,
    'Lambcasing',
    'pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet',
    55.42,
    76,
    '2020-10-27 00:00:00',
    6,
    '-'
  ),
  (
    725,
    'Salmon Steak - Cohoe 8 Oz',
    'sapien a libero nam dui proin leo odio porttitor id consequat in',
    38.96,
    21,
    '2020-09-10 00:00:00',
    6,
    '-'
  ),
  (
    726,
    'Cheese - Fontina',
    'praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia',
    22.05,
    85,
    '2021-03-25 00:00:00',
    4,
    '-'
  ),
  (
    727,
    'Pails With Lids',
    'nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec',
    3.75,
    52,
    '2020-10-04 00:00:00',
    5,
    '-'
  ),
  (
    728,
    'Pork - Smoked Kassler',
    'duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis',
    30.41,
    4,
    '2021-01-18 00:00:00',
    3,
    '-'
  ),
  (
    729,
    'Juice - Cranberry, 341 Ml',
    'in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non',
    3.74,
    48,
    '2020-12-19 00:00:00',
    5,
    '-'
  ),
  (
    730,
    'Lettuce - Red Leaf',
    'sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue',
    62.54,
    39,
    '2021-02-25 00:00:00',
    4,
    '-'
  ),
  (
    731,
    'Garbag Bags - Black',
    'convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum',
    10.00,
    83,
    '2020-12-30 00:00:00',
    3,
    '-'
  ),
  (
    732,
    'Mustard - Individual Pkg',
    'dui proin leo odio porttitor id consequat in consequat ut nulla sed',
    39.85,
    82,
    '2020-08-09 00:00:00',
    6,
    '-'
  ),
  (
    733,
    'Wine - White, Gewurtzraminer',
    'sapien non mi integer ac neque duis bibendum morbi non quam',
    20.81,
    38,
    '2020-09-15 00:00:00',
    4,
    '-'
  ),
  (
    734,
    'Tea - Black Currant',
    'sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue',
    87.59,
    82,
    '2021-03-25 00:00:00',
    5,
    '-'
  ),
  (
    735,
    'Chicken - Whole Fryers',
    'eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut',
    92.72,
    44,
    '2020-08-23 00:00:00',
    6,
    '-'
  ),
  (
    736,
    'Iced Tea - Lemon, 460 Ml',
    'cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum',
    10.87,
    93,
    '2020-11-11 00:00:00',
    6,
    '-'
  ),
  (
    737,
    'Anchovy Paste - 56 G Tube',
    'lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed',
    91.27,
    73,
    '2021-03-02 00:00:00',
    6,
    '-'
  ),
  (
    738,
    'Spice - Chili Powder Mexican',
    'nulla eget eros elementum pellentesque quisque porta volutpat erat quisque',
    81.19,
    46,
    '2021-01-15 00:00:00',
    5,
    '-'
  ),
  (
    739,
    'Milk - Buttermilk',
    'ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu',
    51.96,
    46,
    '2020-07-09 00:00:00',
    4,
    '-'
  ),
  (
    740,
    'Teriyaki Sauce',
    'in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem',
    74.90,
    6,
    '2021-01-19 00:00:00',
    6,
    '-'
  ),
  (
    741,
    'Mcgillicuddy Vanilla Schnap',
    'posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed',
    6.59,
    8,
    '2021-04-25 00:00:00',
    6,
    '-'
  ),
  (
    742,
    'Syrup - Monin - Blue Curacao',
    'elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla',
    4.21,
    0,
    '2020-10-24 00:00:00',
    5,
    '-'
  ),
  (
    743,
    'Bagels Poppyseed',
    'praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante',
    41.27,
    46,
    '2020-07-05 00:00:00',
    6,
    '-'
  ),
  (
    744,
    'Bread - Focaccia Quarter',
    'odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut',
    97.63,
    63,
    '2020-10-21 00:00:00',
    5,
    '-'
  ),
  (
    745,
    'Quinoa',
    'consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla',
    98.74,
    75,
    '2020-06-20 00:00:00',
    4,
    '-'
  ),
  (
    746,
    'Eggplant - Regular',
    'sed accumsan felis ut at dolor quis odio consequat varius integer ac leo',
    17.56,
    26,
    '2020-12-02 00:00:00',
    6,
    '-'
  ),
  (
    747,
    'Bagels Poppyseed',
    'sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante',
    53.78,
    22,
    '2020-08-26 00:00:00',
    6,
    '-'
  ),
  (
    748,
    'Bread - Hamburger Buns',
    'ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae',
    23.54,
    93,
    '2020-09-13 00:00:00',
    6,
    '-'
  ),
  (
    749,
    'Bread - Roll, Calabrese',
    'ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros',
    85.75,
    49,
    '2021-04-09 00:00:00',
    5,
    '-'
  ),
  (
    750,
    'Apricots - Dried',
    'ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis',
    38.67,
    81,
    '2021-02-06 00:00:00',
    3,
    '-'
  ),
  (
    751,
    'Tea - Mint',
    'hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam',
    24.54,
    17,
    '2020-12-27 00:00:00',
    3,
    '-'
  ),
  (
    752,
    'Beef - Shank',
    'ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies',
    34.42,
    24,
    '2021-04-20 00:00:00',
    4,
    '-'
  ),
  (
    753,
    'Soup - Beef, Base Mix',
    'tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut',
    42.17,
    81,
    '2020-11-25 00:00:00',
    4,
    '-'
  ),
  (
    754,
    'Horseradish - Prepared',
    'at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id',
    58.71,
    3,
    '2020-07-23 00:00:00',
    5,
    '-'
  ),
  (
    755,
    'Snapple Raspberry Tea',
    'odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut',
    53.58,
    53,
    '2020-12-12 00:00:00',
    5,
    '-'
  ),
  (
    756,
    'Pastry - Apple Muffins - Mini',
    'sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis',
    39.85,
    93,
    '2021-05-06 00:00:00',
    3,
    '-'
  ),
  (
    757,
    'Cheese - Cheddar, Old White',
    'libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis',
    89.36,
    78,
    '2020-08-03 00:00:00',
    6,
    '-'
  ),
  (
    758,
    'Syrup - Monin - Granny Smith',
    'id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit',
    8.14,
    3,
    '2020-10-04 00:00:00',
    5,
    '-'
  ),
  (
    759,
    'Cinnamon Rolls',
    'tortor duis mattis egestas metus aenean fermentum donec ut mauris',
    62.92,
    78,
    '2021-02-19 00:00:00',
    4,
    '-'
  ),
  (
    760,
    'Sparkling Wine - Rose, Freixenet',
    'mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet',
    67.78,
    32,
    '2020-06-25 00:00:00',
    5,
    '-'
  ),
  (
    761,
    'Sultanas',
    'erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit',
    7.33,
    1,
    '2020-10-26 00:00:00',
    6,
    '-'
  ),
  (
    762,
    'Pepper - Green',
    'in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus',
    97.54,
    5,
    '2021-04-24 00:00:00',
    3,
    '-'
  ),
  (
    763,
    'Cheese - Ricotta',
    'eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet',
    25.22,
    35,
    '2021-01-27 00:00:00',
    4,
    '-'
  ),
  (
    764,
    'Hot Choc Vending',
    'et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium',
    82.25,
    74,
    '2021-06-01 00:00:00',
    6,
    '-'
  ),
  (
    765,
    'Tomato - Tricolor Cherry',
    'eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus',
    21.61,
    34,
    '2020-11-17 00:00:00',
    3,
    '-'
  ),
  (
    766,
    'Cookie Double Choco',
    'leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa',
    72.75,
    90,
    '2021-05-26 00:00:00',
    4,
    '-'
  ),
  (
    767,
    'Frangelico',
    'orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus',
    59.70,
    81,
    '2021-05-18 00:00:00',
    4,
    '-'
  ),
  (
    768,
    'Wine - Muscadet Sur Lie',
    'turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam',
    22.25,
    89,
    '2020-07-21 00:00:00',
    5,
    '-'
  ),
  (
    769,
    'Steel Wool',
    'mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh',
    20.32,
    55,
    '2021-01-27 00:00:00',
    5,
    '-'
  ),
  (
    770,
    'Olives - Morracan Dired',
    'consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam',
    32.72,
    10,
    '2021-02-28 00:00:00',
    4,
    '-'
  ),
  (
    771,
    'Tomato Puree',
    'adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in',
    55.37,
    37,
    '2020-10-27 00:00:00',
    3,
    '-'
  ),
  (
    772,
    'Sobe - Orange Carrot',
    'sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at',
    84.76,
    80,
    '2021-01-08 00:00:00',
    5,
    '-'
  ),
  (
    773,
    'Beef Wellington',
    'amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec',
    20.72,
    18,
    '2020-08-09 00:00:00',
    4,
    '-'
  ),
  (
    774,
    'Table Cloth 90x90 Colour',
    'placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget',
    70.40,
    12,
    '2021-01-13 00:00:00',
    3,
    '-'
  ),
  (
    775,
    'Flour - Semolina',
    'fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede',
    40.01,
    63,
    '2020-12-07 00:00:00',
    6,
    '-'
  ),
  (
    776,
    'Sobe - Berry Energy',
    'consequat dui nec nisi volutpat eleifend donec ut dolor morbi',
    14.85,
    70,
    '2021-01-10 00:00:00',
    4,
    '-'
  ),
  (
    777,
    'Mcguinness - Blue Curacao',
    'ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque',
    94.68,
    60,
    '2020-06-13 00:00:00',
    4,
    '-'
  ),
  (
    778,
    'Bag Stand',
    'nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer',
    63.02,
    22,
    '2021-01-18 00:00:00',
    4,
    '-'
  ),
  (
    779,
    'Waffle Stix',
    'vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor',
    88.15,
    18,
    '2020-12-13 00:00:00',
    3,
    '-'
  ),
  (
    780,
    'Bread - Frozen Basket Variety',
    'nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et',
    89.47,
    2,
    '2020-12-25 00:00:00',
    6,
    '-'
  ),
  (
    781,
    'Wine - Shiraz South Eastern',
    'sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque',
    62.23,
    47,
    '2021-01-16 00:00:00',
    6,
    '-'
  ),
  (
    782,
    'Wine - Jaboulet Cotes Du Rhone',
    'eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at',
    84.37,
    43,
    '2021-06-07 00:00:00',
    5,
    '-'
  ),
  (
    783,
    'Bandage - Finger Cots',
    'ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices',
    28.05,
    64,
    '2021-03-20 00:00:00',
    4,
    '-'
  ),
  (
    784,
    'Bread Ww Cluster',
    'nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus',
    24.96,
    71,
    '2020-11-28 00:00:00',
    5,
    '-'
  ),
  (
    785,
    'Sauce - Plum',
    'adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis',
    4.87,
    26,
    '2020-10-15 00:00:00',
    5,
    '-'
  ),
  (
    786,
    'Salmon - Atlantic, Skin On',
    'quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in',
    40.60,
    57,
    '2020-11-03 00:00:00',
    4,
    '-'
  ),
  (
    787,
    'Tea - Decaf Lipton',
    'in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem',
    99.45,
    87,
    '2020-11-30 00:00:00',
    5,
    '-'
  ),
  (
    788,
    'Cake - Cake Sheet Macaroon',
    'lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque',
    25.66,
    63,
    '2021-05-25 00:00:00',
    6,
    '-'
  ),
  (
    789,
    'Wine - Magnotta, Merlot Sr Vqa',
    'mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue',
    95.54,
    61,
    '2021-04-21 00:00:00',
    4,
    '-'
  ),
  (
    790,
    'Apples - Spartan',
    'in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio',
    40.39,
    47,
    '2020-09-02 00:00:00',
    6,
    '-'
  ),
  (
    791,
    'Pie Box - Cello Window 2.5',
    'donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac',
    84.34,
    68,
    '2020-09-12 00:00:00',
    3,
    '-'
  ),
  (
    792,
    'Spice - Peppercorn Melange',
    'at turpis a pede posuere nonummy integer non velit donec',
    63.42,
    53,
    '2021-04-23 00:00:00',
    6,
    '-'
  ),
  (
    793,
    'Cherries - Bing, Canned',
    'nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget',
    7.50,
    74,
    '2021-05-20 00:00:00',
    6,
    '-'
  ),
  (
    794,
    'Bread - English Muffin',
    'platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis',
    20.67,
    70,
    '2020-09-26 00:00:00',
    6,
    '-'
  ),
  (
    795,
    'Trueblue - Blueberry',
    'cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor',
    93.86,
    81,
    '2021-04-24 00:00:00',
    3,
    '-'
  ),
  (
    796,
    'Longos - Penne With Pesto',
    'turpis integer aliquet massa id lobortis convallis tortor risus dapibus',
    95.72,
    53,
    '2020-10-24 00:00:00',
    5,
    '-'
  ),
  (
    797,
    'Lamb - Loin, Trimmed, Boneless',
    'eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a',
    38.98,
    97,
    '2020-09-04 00:00:00',
    6,
    '-'
  ),
  (
    798,
    'Wine - Rioja Campo Viejo',
    'nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi',
    95.76,
    84,
    '2021-02-17 00:00:00',
    3,
    '-'
  ),
  (
    799,
    'Loquat',
    'eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium',
    26.98,
    66,
    '2020-09-15 00:00:00',
    3,
    '-'
  ),
  (
    800,
    'Hold Up Tool Storage Rack',
    'nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in',
    4.35,
    89,
    '2020-10-28 00:00:00',
    3,
    '-'
  ),
  (
    801,
    'Parsley - Dried',
    'morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar',
    4.62,
    61,
    '2020-07-25 00:00:00',
    4,
    '-'
  ),
  (
    802,
    'Plasticforkblack',
    'nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed',
    50.81,
    58,
    '2020-12-23 00:00:00',
    6,
    '-'
  ),
  (
    803,
    'Potato - Sweet',
    'a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla',
    63.85,
    59,
    '2020-12-09 00:00:00',
    4,
    '-'
  ),
  (
    804,
    'Coffee - Cafe Moreno',
    'ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo',
    15.59,
    91,
    '2021-01-02 00:00:00',
    6,
    '-'
  ),
  (
    805,
    'Wine - Red, Colio Cabernet',
    'lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium',
    96.99,
    59,
    '2021-03-23 00:00:00',
    3,
    '-'
  ),
  (
    806,
    'Ostrich - Fan Fillet',
    'orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio',
    60.59,
    23,
    '2020-11-23 00:00:00',
    4,
    '-'
  ),
  (
    807,
    'Green Tea Refresher',
    'sed accumsan felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec vitae',
    57.25,
    90,
    '2021-05-04 00:00:00',
    3,
    '-'
  ),
  (
    808,
    'Flour - Rye',
    'lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor',
    88.01,
    18,
    '2021-02-03 00:00:00',
    6,
    '-'
  ),
  (
    809,
    'Sugar Thermometer',
    'eu orci mauris lacinia sapien quis libero nullam sit amet',
    97.85,
    81,
    '2020-09-11 00:00:00',
    6,
    '-'
  ),
  (
    810,
    'Wine - Tio Pepe Sherry Fino',
    'molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget',
    47.11,
    67,
    '2021-02-20 00:00:00',
    3,
    '-'
  ),
  (
    811,
    'Cassis',
    'ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et',
    94.98,
    96,
    '2021-01-17 00:00:00',
    3,
    '-'
  ),
  (
    812,
    'Ice Cream - Super Sandwich',
    'tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien',
    15.08,
    84,
    '2021-01-19 00:00:00',
    6,
    '-'
  ),
  (
    813,
    'Sauce - Salsa',
    'lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras',
    88.19,
    73,
    '2021-05-26 00:00:00',
    3,
    '-'
  ),
  (
    814,
    'Jerusalem Artichoke',
    'faucibus cursus urna ut tellus nulla ut erat id mauris vulputate',
    60.16,
    87,
    '2021-03-05 00:00:00',
    3,
    '-'
  ),
  (
    815,
    'Juice - Prune',
    'luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus',
    70.29,
    45,
    '2020-06-22 00:00:00',
    6,
    '-'
  ),
  (
    816,
    'Lamb - Sausage Casings',
    'justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec',
    52.51,
    89,
    '2020-09-05 00:00:00',
    5,
    '-'
  ),
  (
    817,
    'Cleaner - Lime Away',
    'nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse',
    24.67,
    39,
    '2021-02-14 00:00:00',
    4,
    '-'
  ),
  (
    818,
    'Flour Dark Rye',
    'ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed',
    99.45,
    93,
    '2020-08-20 00:00:00',
    4,
    '-'
  ),
  (
    819,
    'Chef Hat 20cm',
    'justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus',
    53.60,
    55,
    '2021-01-16 00:00:00',
    3,
    '-'
  ),
  (
    820,
    'Pork - Sausage, Medium',
    'in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus',
    56.86,
    26,
    '2021-02-25 00:00:00',
    4,
    '-'
  ),
  (
    821,
    'Iced Tea - Lemon, 460 Ml',
    'tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia',
    3.29,
    68,
    '2021-03-20 00:00:00',
    5,
    '-'
  ),
  (
    822,
    'Lobak',
    'dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia',
    82.45,
    27,
    '2021-01-28 00:00:00',
    5,
    '-'
  ),
  (
    823,
    'Juice - Apple, 500 Ml',
    'ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce',
    47.96,
    50,
    '2021-04-02 00:00:00',
    3,
    '-'
  ),
  (
    824,
    'Cheese - La Sauvagine',
    'amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus',
    76.15,
    61,
    '2021-01-17 00:00:00',
    4,
    '-'
  ),
  (
    825,
    'Plasticknivesblack',
    'nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio',
    46.41,
    62,
    '2020-07-28 00:00:00',
    5,
    '-'
  ),
  (
    826,
    'Broom - Push',
    'morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra',
    65.92,
    65,
    '2020-10-29 00:00:00',
    3,
    '-'
  ),
  (
    827,
    'Cookies - Assorted',
    'diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus',
    2.58,
    66,
    '2020-06-30 00:00:00',
    6,
    '-'
  ),
  (
    828,
    'Shrimp - 150 - 250',
    'sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus',
    72.34,
    29,
    '2021-04-27 00:00:00',
    5,
    '-'
  ),
  (
    829,
    'Toamtoes 6x7 Select',
    'est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu',
    74.25,
    44,
    '2020-11-05 00:00:00',
    6,
    '-'
  ),
  (
    830,
    'Duck - Breast',
    'consequat ut nulla sed accumsan felis ut at dolor quis odio',
    93.37,
    100,
    '2020-10-04 00:00:00',
    5,
    '-'
  ),
  (
    831,
    'Spice - Chili Powder Mexican',
    'sapien a libero nam dui proin leo odio porttitor id',
    7.24,
    68,
    '2020-07-25 00:00:00',
    3,
    '-'
  ),
  (
    832,
    'Mushroom - Chanterelle Frozen',
    'justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut',
    9.80,
    27,
    '2020-10-01 00:00:00',
    5,
    '-'
  ),
  (
    833,
    'Wine - Red, Gallo, Merlot',
    'pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus',
    49.76,
    31,
    '2021-05-31 00:00:00',
    6,
    '-'
  ),
  (
    834,
    'Wine - Puligny Montrachet A.',
    'nulla ut erat id mauris vulputate elementum nullam varius nulla',
    88.48,
    10,
    '2020-11-18 00:00:00',
    3,
    '-'
  ),
  (
    835,
    'Sole - Dover, Whole, Fresh',
    'in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti',
    54.55,
    42,
    '2020-07-22 00:00:00',
    5,
    '-'
  ),
  (
    836,
    'Pork Ham Prager',
    'adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit',
    35.20,
    15,
    '2021-02-16 00:00:00',
    6,
    '-'
  ),
  (
    837,
    'Beef - Sushi Flat Iron Steak',
    'pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc',
    24.61,
    9,
    '2020-12-17 00:00:00',
    6,
    '-'
  ),
  (
    838,
    'General Purpose Trigger',
    'lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus',
    57.76,
    89,
    '2020-07-24 00:00:00',
    4,
    '-'
  ),
  (
    839,
    'Chicken - White Meat With Tender',
    'tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec',
    43.96,
    64,
    '2020-11-13 00:00:00',
    6,
    '-'
  ),
  (
    840,
    'Veal - Osso Bucco',
    'tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat',
    47.20,
    48,
    '2020-11-23 00:00:00',
    4,
    '-'
  ),
  (
    841,
    'Soup - Beef Conomme, Dry',
    'lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam',
    81.56,
    86,
    '2020-07-17 00:00:00',
    5,
    '-'
  ),
  (
    842,
    'Aromat Spice / Seasoning',
    'nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus',
    53.24,
    43,
    '2021-01-16 00:00:00',
    5,
    '-'
  ),
  (
    843,
    'Veal - Loin',
    'fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis',
    15.52,
    66,
    '2021-04-07 00:00:00',
    3,
    '-'
  ),
  (
    844,
    'Beef - Cooked, Corned',
    'dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt',
    62.21,
    56,
    '2021-04-29 00:00:00',
    5,
    '-'
  ),
  (
    845,
    'Crawfish',
    'malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet',
    8.68,
    26,
    '2020-09-06 00:00:00',
    6,
    '-'
  ),
  (
    846,
    'Pastry - Mini French Pastries',
    'amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi',
    30.74,
    66,
    '2021-01-12 00:00:00',
    3,
    '-'
  ),
  (
    847,
    'Food Colouring - Green',
    'quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse',
    64.27,
    12,
    '2020-12-22 00:00:00',
    3,
    '-'
  ),
  (
    848,
    'Chicken - Breast, 5 - 7 Oz',
    'vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices',
    32.82,
    72,
    '2021-03-25 00:00:00',
    6,
    '-'
  ),
  (
    849,
    'Brownies - Two Bite, Chocolate',
    'ultrices libero non mattis pulvinar nulla pede ullamcorper augue a',
    69.04,
    69,
    '2021-05-03 00:00:00',
    6,
    '-'
  ),
  (
    850,
    'Peppercorns - Green',
    'vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet',
    59.43,
    11,
    '2020-07-11 00:00:00',
    6,
    '-'
  ),
  (
    851,
    'Beef Dry Aged Tenderloin Aaa',
    'morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui',
    55.63,
    31,
    '2020-11-26 00:00:00',
    5,
    '-'
  ),
  (
    852,
    'Soup - Cream Of Potato / Leek',
    'ut nulla sed accumsan felis ut at dolor quis odio consequat varius integer ac leo',
    4.49,
    52,
    '2020-10-27 00:00:00',
    4,
    '-'
  ),
  (
    853,
    'Corn - On The Cob',
    'ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque',
    98.90,
    51,
    '2020-09-02 00:00:00',
    4,
    '-'
  ),
  (
    854,
    'Cream - 18%',
    'integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor',
    37.33,
    74,
    '2021-05-03 00:00:00',
    5,
    '-'
  ),
  (
    855,
    'Lobster - Cooked',
    'interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia',
    9.93,
    91,
    '2021-04-03 00:00:00',
    6,
    '-'
  ),
  (
    856,
    'Pork - Hock And Feet Attached',
    'ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id',
    47.68,
    26,
    '2021-06-07 00:00:00',
    3,
    '-'
  ),
  (
    857,
    'Wine - Red, Marechal Foch',
    'phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in',
    78.94,
    77,
    '2021-04-02 00:00:00',
    3,
    '-'
  ),
  (
    858,
    'Salmon Steak - Cohoe 8 Oz',
    'aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a',
    3.38,
    98,
    '2021-05-23 00:00:00',
    6,
    '-'
  ),
  (
    859,
    'Salmon Steak - Cohoe 8 Oz',
    'mi in porttitor pede justo eu massa donec dapibus duis at',
    61.72,
    11,
    '2021-03-24 00:00:00',
    4,
    '-'
  ),
  (
    860,
    'Onions - Vidalia',
    'maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas',
    7.96,
    24,
    '2020-07-21 00:00:00',
    6,
    '-'
  ),
  (
    861,
    'Cheese - Brick With Onion',
    'eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis',
    83.98,
    12,
    '2020-08-29 00:00:00',
    3,
    '-'
  ),
  (
    862,
    'Juice - Apple, 500 Ml',
    'ligula in lacus curabitur at ipsum ac tellus semper interdum',
    91.83,
    41,
    '2020-06-20 00:00:00',
    6,
    '-'
  ),
  (
    863,
    'Coffee Cup 12oz 5342cd',
    'mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam nam tristique',
    91.88,
    60,
    '2021-04-28 00:00:00',
    6,
    '-'
  ),
  (
    864,
    'Appetizer - Crab And Brie',
    'metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices',
    77.29,
    94,
    '2021-04-30 00:00:00',
    5,
    '-'
  ),
  (
    865,
    'Heavy Duty Dust Pan',
    'ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec',
    97.70,
    6,
    '2020-07-25 00:00:00',
    6,
    '-'
  ),
  (
    866,
    'Devonshire Cream',
    'mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis',
    28.21,
    6,
    '2021-01-04 00:00:00',
    4,
    '-'
  ),
  (
    867,
    'Soup - Chicken And Wild Rice',
    'urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo',
    36.20,
    74,
    '2020-07-29 00:00:00',
    5,
    '-'
  ),
  (
    868,
    'Lamb - Ground',
    'nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at',
    67.34,
    34,
    '2021-05-09 00:00:00',
    5,
    '-'
  ),
  (
    869,
    'Nut - Walnut, Pieces',
    'praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante',
    90.88,
    63,
    '2021-02-24 00:00:00',
    4,
    '-'
  ),
  (
    870,
    'Pail With Metal Handle 16l White',
    'diam cras pellentesque volutpat dui maecenas tristique est et tempus semper',
    67.41,
    96,
    '2020-10-12 00:00:00',
    4,
    '-'
  ),
  (
    871,
    'Cheese - Stilton',
    'porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis',
    54.74,
    84,
    '2021-05-24 00:00:00',
    3,
    '-'
  ),
  (
    872,
    'Edible Flower - Mixed',
    'massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat',
    17.58,
    50,
    '2020-12-08 00:00:00',
    3,
    '-'
  ),
  (
    873,
    'Vinegar - Rice',
    'volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus',
    13.34,
    60,
    '2021-01-25 00:00:00',
    4,
    '-'
  ),
  (
    874,
    'Jameson - Irish Whiskey',
    'ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor',
    70.75,
    42,
    '2021-04-23 00:00:00',
    4,
    '-'
  ),
  (
    875,
    'Milk - Condensed',
    'nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy',
    72.56,
    57,
    '2020-06-30 00:00:00',
    3,
    '-'
  ),
  (
    876,
    'Coffee - Beans, Whole',
    'cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient',
    38.07,
    31,
    '2021-05-06 00:00:00',
    5,
    '-'
  ),
  (
    877,
    'Tea - Honey Green Tea',
    'hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget',
    34.94,
    59,
    '2020-07-15 00:00:00',
    4,
    '-'
  ),
  (
    878,
    'Mountain Dew',
    'sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce',
    72.29,
    78,
    '2020-06-18 00:00:00',
    3,
    '-'
  ),
  (
    879,
    'Dehydrated Kelp Kombo',
    'posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl',
    19.22,
    42,
    '2020-11-24 00:00:00',
    4,
    '-'
  ),
  (
    880,
    'Ham - Cooked Italian',
    'porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam',
    69.17,
    36,
    '2020-09-03 00:00:00',
    4,
    '-'
  ),
  (
    881,
    'Pasta - Penne, Rigate, Dry',
    'sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper',
    68.17,
    14,
    '2020-07-24 00:00:00',
    3,
    '-'
  ),
  (
    882,
    'Vinegar - White Wine',
    'ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam',
    1.41,
    95,
    '2021-01-02 00:00:00',
    4,
    '-'
  ),
  (
    883,
    'Chicken - Leg / Back Attach',
    'sed augue aliquam erat volutpat in congue etiam justo etiam pretium',
    62.32,
    8,
    '2020-12-06 00:00:00',
    3,
    '-'
  ),
  (
    884,
    'Dc Hikiage Hira Huba',
    'duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis',
    86.10,
    88,
    '2020-12-31 00:00:00',
    3,
    '-'
  ),
  (
    885,
    'Beets',
    'morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est',
    4.77,
    79,
    '2020-09-19 00:00:00',
    5,
    '-'
  ),
  (
    886,
    'Cinnamon Buns Sticky',
    'neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan',
    84.08,
    81,
    '2020-09-06 00:00:00',
    4,
    '-'
  ),
  (
    887,
    'Bagels Poppyseed',
    'massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo',
    24.20,
    32,
    '2021-03-19 00:00:00',
    6,
    '-'
  ),
  (
    888,
    'Pork - Loin, Boneless',
    'aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam',
    30.54,
    31,
    '2021-01-31 00:00:00',
    3,
    '-'
  ),
  (
    889,
    'Broom And Broom Rack White',
    'aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque',
    65.63,
    63,
    '2020-07-16 00:00:00',
    5,
    '-'
  ),
  (
    890,
    'Filo Dough',
    'amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan',
    29.75,
    8,
    '2021-01-31 00:00:00',
    4,
    '-'
  ),
  (
    891,
    'Mushroom - Morels, Dry',
    'tellus nulla ut erat id mauris vulputate elementum nullam varius',
    93.01,
    99,
    '2021-05-05 00:00:00',
    5,
    '-'
  ),
  (
    892,
    'Milkettes - 2%',
    'ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt',
    39.56,
    27,
    '2021-01-25 00:00:00',
    6,
    '-'
  ),
  (
    893,
    'Flour - Buckwheat, Dark',
    'pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient',
    63.49,
    73,
    '2021-02-23 00:00:00',
    5,
    '-'
  ),
  (
    894,
    'Lemonade - Island Tea, 591 Ml',
    'massa id lobortis convallis tortor risus dapibus augue vel accumsan',
    87.53,
    17,
    '2020-07-29 00:00:00',
    5,
    '-'
  ),
  (
    895,
    'Cup - 8oz Coffee Perforated',
    'integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum',
    4.99,
    51,
    '2021-03-24 00:00:00',
    5,
    '-'
  ),
  (
    896,
    'Wine - Periguita Fonseca',
    'in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla',
    28.30,
    60,
    '2021-01-09 00:00:00',
    5,
    '-'
  ),
  (
    897,
    'Sour Puss - Tangerine',
    'nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue',
    2.28,
    23,
    '2021-03-14 00:00:00',
    4,
    '-'
  ),
  (
    898,
    'Pie Shells 10',
    'dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed',
    93.69,
    5,
    '2020-07-03 00:00:00',
    4,
    '-'
  ),
  (
    899,
    'Steampan Lid',
    'accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi',
    74.10,
    70,
    '2020-09-23 00:00:00',
    6,
    '-'
  ),
  (
    900,
    'Flower - Leather Leaf Fern',
    'elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est',
    74.87,
    40,
    '2020-11-21 00:00:00',
    4,
    '-'
  ),
  (
    901,
    'Tea - Grapefruit Green Tea',
    'mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae',
    55.42,
    40,
    '2021-03-10 00:00:00',
    5,
    '-'
  ),
  (
    902,
    'Nacho Chips',
    'pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia',
    8.37,
    22,
    '2020-12-20 00:00:00',
    5,
    '-'
  ),
  (
    903,
    'Apples - Spartan',
    'dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere',
    45.92,
    93,
    '2021-02-24 00:00:00',
    3,
    '-'
  ),
  (
    904,
    'Salami - Genova',
    'mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate',
    13.74,
    97,
    '2020-07-16 00:00:00',
    4,
    '-'
  ),
  (
    905,
    'Absolut Citron',
    'dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros',
    88.20,
    32,
    '2020-10-23 00:00:00',
    4,
    '-'
  ),
  (
    906,
    'Lumpfish Black',
    'tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo',
    56.77,
    62,
    '2020-07-17 00:00:00',
    5,
    '-'
  ),
  (
    907,
    'Lamb - Whole, Frozen',
    'duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit',
    16.64,
    39,
    '2020-11-10 00:00:00',
    5,
    '-'
  ),
  (
    908,
    'Soup - Campbells',
    'sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis',
    58.28,
    78,
    '2020-12-13 00:00:00',
    4,
    '-'
  ),
  (
    909,
    'Bread - Mini Hamburger Bun',
    'eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique',
    3.98,
    56,
    '2021-05-10 00:00:00',
    4,
    '-'
  ),
  (
    910,
    'Beef - Top Butt Aaa',
    'ut suscipit a feugiat et eros vestibulum ac est lacinia nisi',
    70.60,
    93,
    '2020-10-23 00:00:00',
    5,
    '-'
  ),
  (
    911,
    'The Pop Shoppe - Root Beer',
    'vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam',
    81.50,
    97,
    '2020-11-28 00:00:00',
    3,
    '-'
  ),
  (
    912,
    'Wine - Niagara Peninsula Vqa',
    'erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper',
    77.05,
    87,
    '2021-03-31 00:00:00',
    6,
    '-'
  ),
  (
    913,
    'Wine - Red, Mouton Cadet',
    'nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy',
    16.96,
    32,
    '2020-12-05 00:00:00',
    5,
    '-'
  ),
  (
    914,
    'Longos - Chicken Cordon Bleu',
    'interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat',
    64.01,
    90,
    '2020-06-21 00:00:00',
    4,
    '-'
  ),
  (
    915,
    'Lamb - Ground',
    'metus aenean fermentum donec ut mauris eget massa tempor convallis nulla',
    73.04,
    92,
    '2020-11-07 00:00:00',
    3,
    '-'
  ),
  (
    916,
    'Sour Puss Sour Apple',
    'nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros',
    59.71,
    1,
    '2021-05-21 00:00:00',
    4,
    '-'
  ),
  (
    917,
    'Gingerale - Diet - Schweppes',
    'enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper',
    80.01,
    96,
    '2020-12-21 00:00:00',
    4,
    '-'
  ),
  (
    918,
    'Soup - Base Broth Chix',
    'nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus',
    1.82,
    45,
    '2020-08-03 00:00:00',
    4,
    '-'
  ),
  (
    919,
    'Bread - French Stick',
    'mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae',
    62.49,
    73,
    '2020-09-18 00:00:00',
    4,
    '-'
  ),
  (
    920,
    'Turnip - White, Organic',
    'nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta',
    43.91,
    63,
    '2021-05-30 00:00:00',
    5,
    '-'
  ),
  (
    921,
    'Flour - Semolina',
    'accumsan felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec',
    25.44,
    16,
    '2020-12-17 00:00:00',
    5,
    '-'
  ),
  (
    922,
    'Snapple Lemon Tea',
    'nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus',
    92.30,
    49,
    '2020-12-06 00:00:00',
    6,
    '-'
  ),
  (
    923,
    'Chocolate - Semi Sweet',
    'justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut',
    93.91,
    46,
    '2020-11-12 00:00:00',
    3,
    '-'
  ),
  (
    924,
    'Apple - Fuji',
    'ut tellus nulla ut erat id mauris vulputate elementum nullam varius',
    82.27,
    22,
    '2020-12-08 00:00:00',
    6,
    '-'
  ),
  (
    925,
    'Oil - Grapeseed Oil',
    'luctus et ultrices posuere cubilia curae duis faucibus accumsan odio',
    11.68,
    87,
    '2020-09-05 00:00:00',
    5,
    '-'
  ),
  (
    926,
    'Ham - Cooked',
    'orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum',
    57.01,
    16,
    '2021-02-10 00:00:00',
    4,
    '-'
  ),
  (
    927,
    'Blackberries',
    'aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi',
    22.24,
    17,
    '2020-07-21 00:00:00',
    4,
    '-'
  ),
  (
    928,
    'Onions - Spanish',
    'tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque',
    99.83,
    15,
    '2021-06-09 00:00:00',
    3,
    '-'
  ),
  (
    929,
    'Wheat - Soft Kernal Of Wheat',
    'non velit donec diam neque vestibulum eget vulputate ut ultrices vel',
    38.36,
    28,
    '2020-08-18 00:00:00',
    5,
    '-'
  ),
  (
    930,
    'Tandoori Curry Paste',
    'sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum',
    15.51,
    7,
    '2021-04-03 00:00:00',
    4,
    '-'
  ),
  (
    931,
    'Ice Cream Bar - Oreo Sandwich',
    'eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus',
    29.51,
    43,
    '2020-09-09 00:00:00',
    4,
    '-'
  ),
  (
    932,
    'Instant Coffee',
    'adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus',
    67.65,
    26,
    '2021-03-16 00:00:00',
    4,
    '-'
  ),
  (
    933,
    'Yogurt - Blueberry, 175 Gr',
    'tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet',
    93.57,
    8,
    '2020-09-07 00:00:00',
    5,
    '-'
  ),
  (
    934,
    'Juice - Orange 1.89l',
    'habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla',
    24.33,
    63,
    '2020-07-20 00:00:00',
    4,
    '-'
  ),
  (
    935,
    'Clams - Littleneck, Whole',
    'ut dolor morbi vel lectus in quam fringilla rhoncus mauris',
    80.37,
    45,
    '2020-08-19 00:00:00',
    4,
    '-'
  ),
  (
    936,
    'Chicken - Whole Fryers',
    'ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam',
    59.14,
    59,
    '2021-01-09 00:00:00',
    3,
    '-'
  ),
  (
    937,
    'Tart - Lemon',
    'sem fusce consequat nulla nisl nunc nisl duis bibendum felis',
    56.34,
    88,
    '2020-10-06 00:00:00',
    6,
    '-'
  ),
  (
    938,
    'Pesto - Primerba, Paste',
    'lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat',
    85.67,
    27,
    '2021-01-16 00:00:00',
    6,
    '-'
  ),
  (
    939,
    'Apple - Granny Smith',
    'convallis nunc proin at turpis a pede posuere nonummy integer non',
    77.92,
    68,
    '2020-09-30 00:00:00',
    4,
    '-'
  ),
  (
    940,
    'Cranberries - Dry',
    'pellentesque volutpat dui maecenas tristique est et tempus semper est',
    50.45,
    87,
    '2020-08-14 00:00:00',
    5,
    '-'
  ),
  (
    941,
    'Sponge Cake Mix - Chocolate',
    'eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum',
    72.18,
    84,
    '2021-03-04 00:00:00',
    5,
    '-'
  ),
  (
    942,
    'Daikon Radish',
    'a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis',
    12.90,
    47,
    '2021-05-30 00:00:00',
    6,
    '-'
  ),
  (
    943,
    'Bread - Roll, Whole Wheat',
    'orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum',
    85.47,
    95,
    '2020-09-05 00:00:00',
    6,
    '-'
  ),
  (
    944,
    'Wine - White, French Cross',
    'convallis nulla neque libero convallis eget eleifend luctus ultricies eu',
    19.88,
    88,
    '2021-01-06 00:00:00',
    3,
    '-'
  ),
  (
    945,
    'Numi - Assorted Teas',
    'hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc',
    29.59,
    7,
    '2020-12-22 00:00:00',
    3,
    '-'
  ),
  (
    946,
    'Longos - Chicken Cordon Bleu',
    'vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc',
    46.23,
    46,
    '2021-05-26 00:00:00',
    5,
    '-'
  ),
  (
    947,
    'Spice - Pepper Portions',
    'nunc proin at turpis a pede posuere nonummy integer non',
    7.48,
    100,
    '2020-08-29 00:00:00',
    4,
    '-'
  ),
  (
    948,
    'Pastry - Cheese Baked Scones',
    'rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat',
    48.37,
    3,
    '2020-08-19 00:00:00',
    3,
    '-'
  ),
  (
    949,
    'Sprouts - Pea',
    'urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium',
    76.76,
    82,
    '2021-02-02 00:00:00',
    3,
    '-'
  ),
  (
    950,
    'Yoghurt Tubes',
    'sapien sapien non mi integer ac neque duis bibendum morbi non',
    97.98,
    34,
    '2020-10-01 00:00:00',
    4,
    '-'
  ),
  (
    951,
    'Ginger - Pickled',
    'cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient',
    49.31,
    56,
    '2020-06-28 00:00:00',
    4,
    '-'
  ),
  (
    952,
    'Salmon Steak - Cohoe 6 Oz',
    'vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam',
    16.26,
    35,
    '2020-06-18 00:00:00',
    3,
    '-'
  ),
  (
    953,
    'Loaf Pan - 2 Lb, Foil',
    'in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices',
    31.72,
    85,
    '2020-08-29 00:00:00',
    5,
    '-'
  ),
  (
    954,
    'Pastry - Choclate Baked',
    'at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue',
    64.81,
    65,
    '2021-02-08 00:00:00',
    3,
    '-'
  ),
  (
    955,
    'Mustard - Seed',
    'pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices',
    21.70,
    7,
    '2021-03-09 00:00:00',
    4,
    '-'
  ),
  (
    956,
    'Mushroom - Enoki, Fresh',
    'curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend',
    94.14,
    36,
    '2021-06-03 00:00:00',
    6,
    '-'
  ),
  (
    957,
    'Coffee - Colombian, Portioned',
    'enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh',
    30.80,
    88,
    '2020-11-29 00:00:00',
    4,
    '-'
  ),
  (
    958,
    'Juice - Ocean Spray Cranberry',
    'pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc',
    33.25,
    93,
    '2020-06-14 00:00:00',
    6,
    '-'
  ),
  (
    959,
    'Tomato Puree',
    'quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris',
    87.22,
    46,
    '2020-07-29 00:00:00',
    4,
    '-'
  ),
  (
    960,
    'Wine - Rosso Del Veronese Igt',
    'elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante',
    78.05,
    45,
    '2021-05-28 00:00:00',
    3,
    '-'
  ),
  (
    961,
    'Wine - Fume Blanc Fetzer',
    'aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac',
    1.16,
    46,
    '2020-10-25 00:00:00',
    4,
    '-'
  ),
  (
    962,
    'Goldschalger',
    'erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam',
    37.26,
    91,
    '2021-03-16 00:00:00',
    4,
    '-'
  ),
  (
    963,
    'Wine - Manischewitz Concord',
    'id sapien in sapien iaculis congue vivamus metus arcu adipiscing',
    48.87,
    53,
    '2021-04-20 00:00:00',
    4,
    '-'
  ),
  (
    964,
    'Beets - Golden',
    'integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas',
    42.69,
    72,
    '2020-09-11 00:00:00',
    5,
    '-'
  ),
  (
    965,
    'Oysters - Smoked',
    'sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean',
    41.69,
    0,
    '2021-04-29 00:00:00',
    3,
    '-'
  ),
  (
    966,
    'Salmon Atl.whole 8 - 10 Lb',
    'dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida',
    30.31,
    74,
    '2021-01-03 00:00:00',
    6,
    '-'
  ),
  (
    967,
    'Rolled Oats',
    'quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue',
    30.25,
    62,
    '2020-09-07 00:00:00',
    4,
    '-'
  ),
  (
    968,
    'Monkfish - Fresh',
    'ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non',
    71.71,
    98,
    '2020-10-16 00:00:00',
    6,
    '-'
  ),
  (
    969,
    'Carbonated Water - Blackcherry',
    'aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien',
    62.44,
    94,
    '2021-04-21 00:00:00',
    5,
    '-'
  ),
  (
    970,
    'Pur Source',
    'maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem',
    35.58,
    28,
    '2020-08-21 00:00:00',
    3,
    '-'
  ),
  (
    971,
    'Pie Filling - Pumpkin',
    'tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque',
    1.38,
    46,
    '2020-12-01 00:00:00',
    5,
    '-'
  ),
  (
    972,
    'Wonton Wrappers',
    'primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna',
    61.63,
    19,
    '2020-09-26 00:00:00',
    3,
    '-'
  ),
  (
    973,
    'Straw - Regular',
    'luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non',
    14.67,
    3,
    '2021-03-24 00:00:00',
    4,
    '-'
  ),
  (
    974,
    'Sparkling Wine - Rose, Freixenet',
    'congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum',
    56.63,
    66,
    '2020-08-07 00:00:00',
    3,
    '-'
  ),
  (
    975,
    'Galliano',
    'semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero',
    93.29,
    90,
    '2021-01-29 00:00:00',
    5,
    '-'
  ),
  (
    976,
    'Passion Fruit',
    'habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla',
    64.48,
    35,
    '2020-11-27 00:00:00',
    4,
    '-'
  ),
  (
    977,
    'Neckerchief Blck',
    'eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus',
    90.31,
    100,
    '2020-07-14 00:00:00',
    6,
    '-'
  ),
  (
    978,
    'Sugar - Crumb',
    'eget rutrum at lorem integer tincidunt ante vel ipsum praesent',
    87.45,
    0,
    '2021-02-17 00:00:00',
    6,
    '-'
  ),
  (
    979,
    'Oats Large Flake',
    'tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis',
    53.35,
    82,
    '2020-09-17 00:00:00',
    3,
    '-'
  ),
  (
    980,
    'Gelatine Leaves - Envelopes',
    'orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat',
    74.18,
    91,
    '2020-11-19 00:00:00',
    5,
    '-'
  ),
  (
    981,
    'Chicken - Leg / Back Attach',
    'neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci',
    54.26,
    65,
    '2020-08-12 00:00:00',
    3,
    '-'
  ),
  (
    982,
    'Cheese - Comte',
    'curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque',
    75.97,
    42,
    '2020-09-08 00:00:00',
    3,
    '-'
  ),
  (
    983,
    'Vinegar - Champagne',
    'nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit',
    86.92,
    81,
    '2020-06-20 00:00:00',
    5,
    '-'
  ),
  (
    984,
    'Kiwi',
    'nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean',
    79.46,
    99,
    '2021-02-24 00:00:00',
    6,
    '-'
  ),
  (
    985,
    'Kohlrabi',
    'est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium',
    48.16,
    77,
    '2021-03-12 00:00:00',
    3,
    '-'
  ),
  (
    986,
    'Brandy Cherry - Mcguinness',
    'ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus',
    9.64,
    57,
    '2021-01-20 00:00:00',
    3,
    '-'
  ),
  (
    987,
    'Sultanas',
    'sed accumsan felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec',
    62.10,
    1,
    '2020-06-20 00:00:00',
    3,
    '-'
  ),
  (
    988,
    'V8 - Berry Blend',
    'ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at',
    15.77,
    64,
    '2020-07-16 00:00:00',
    5,
    '-'
  ),
  (
    989,
    'Soup - Campbells, Creamy',
    'pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non',
    22.70,
    30,
    '2021-01-06 00:00:00',
    3,
    '-'
  ),
  (
    990,
    'Creamers - 10%',
    'suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa',
    71.17,
    53,
    '2021-01-05 00:00:00',
    5,
    '-'
  ),
  (
    991,
    'Mushroom - Porcini, Dry',
    'turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor',
    41.43,
    36,
    '2020-07-08 00:00:00',
    4,
    '-'
  ),
  (
    992,
    'Cake - Miini Cheesecake Cherry',
    'lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula',
    53.99,
    59,
    '2020-10-27 00:00:00',
    6,
    '-'
  ),
  (
    993,
    'Carbonated Water - Raspberry',
    'proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis',
    32.22,
    51,
    '2021-04-20 00:00:00',
    3,
    '-'
  ),
  (
    994,
    'Cream Of Tartar',
    'sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend',
    35.22,
    44,
    '2020-08-31 00:00:00',
    4,
    '-'
  ),
  (
    995,
    'Club Soda - Schweppes, 355 Ml',
    'sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl',
    8.32,
    61,
    '2021-03-19 00:00:00',
    3,
    '-'
  ),
  (
    996,
    'Beef - Rib Roast, Capless',
    'sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci',
    52.90,
    68,
    '2020-06-20 00:00:00',
    6,
    '-'
  ),
  (
    997,
    'Salt - Table',
    'etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat',
    37.51,
    7,
    '2021-05-02 00:00:00',
    6,
    '-'
  ),
  (
    998,
    'Muffin Hinge 117n',
    'mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate',
    59.84,
    98,
    '2020-06-29 00:00:00',
    3,
    '-'
  ),
  (
    999,
    'Chicken - Wieners',
    'eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare',
    58.57,
    5,
    '2020-08-16 00:00:00',
    6,
    '-'
  ),
  (
    1000,
    'Dried Peach',
    'in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin',
    41.22,
    39,
    '2020-12-12 00:00:00',
    4,
    '-'
  );