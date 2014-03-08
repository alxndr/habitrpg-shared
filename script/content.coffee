_ = require 'lodash'
api = module.exports
moment = require 'moment'
i18n = require './i18n.coffee'
###
  ---------------------------------------------------------------
  Gear (Weapons, Armor, Head, Shield)
  Item definitions: {index, text, notes, value, str, def, int, per, classes, type}
  ---------------------------------------------------------------
###

classes = ['warrior', 'rogue', 'healer', 'wizard']
gearTypes = ['armor', 'weapon', 'shield', 'head', 'back', 'headAccessory']

events =
  winter: {start:'2013-12-31',end:'2014-02-01'}
  birthday: {start:'2013-01-30',end:'2014-02-01'}
  spring: {start:'2014-03-21',end:'2014-05-01'}

mystery =
  201402: {start:'2014-02-22',end:'2014-02-28'}
  201403: {start:'2014-03-24',end:'2014-04-01'}

gear =
  weapon:
    base:
      0: 
        text: (-> i18n.t('weaponBase0Text')), notes: (-> i18n.t('weaponBase0Notes')), value:0
    warrior:
      0: text: (-> i18n.t('weaponWarrior0Text')), notes: (-> i18n.t('weaponWarrior0Notes')), value:0
      1: text: (-> i18n.t('weaponWarrior1Text')), notes: (-> i18n.t('weaponWarrior1Notes', {str: 3})), str: 3, value:20
      2: text: (-> i18n.t('weaponWarrior2Text')), notes: (-> i18n.t('weaponWarrior2Notes', {str: 6})), str: 6, value:30
      3: text: (-> i18n.t('weaponWarrior3Text')), notes: (-> i18n.t('weaponWarrior3Notes', {str: 9})), str: 9, value:45
      4: text: (-> i18n.t('weaponWarrior4Text')), notes: (-> i18n.t('weaponWarrior4Notes', {str: 12})), str: 12, value:65
      5: text: (-> i18n.t('weaponWarrior5Text')), notes: (-> i18n.t('weaponWarrior5Notes', {str: 15})), str: 15, value:90
      6: text: (-> i18n.t('weaponWarrior6Text')), notes: (-> i18n.t('weaponWarrior6Notes', {str: 18})), str: 18, value:120, last: true
    rogue:
      #Not using bows at the moment, but they would be easy to add back in to an advanced Armory feature, as Quest drops, etc.
      #0: twoHanded: true, text: "Practice Bow", notes:'Training weapon. Confers no benefit.', value:0
      #1: twoHanded: true, text: "Short Bow", notes:'Simple bow best at close ranges. Increases STR by 2.', str: 2, value:20
      #2: twoHanded: true, text: "Long Bow", notes:'Bow with a strong draw for extra distance. Increases STR by 5.', str: 5, value:50
      #3: twoHanded: true, text: "Recurve Bow", notes:'Built with advanced techniques. Increases STR by 8.', str: 8, value:80
      #4: twoHanded: true, text: "Icicle Bow", notes:'Fires arrows of piercing cold. Increases STR by 12.', str: 12, value:120
      #5: twoHanded: true, text: "Meteor Bow", notes:'Rains flame upon your foes. Increases STR by 16.', str: 16, value:160
      #6: twoHanded: true, text: "Golden Bow", notes:'As swift as sunlight and as sharp as lightning. Increases STR by 20.', str: 20, value:200, last: true
      0: text: (-> i18n.t('weaponRogue0Text')), notes: (-> i18n.t('weaponRogue0Notes')), str: 0, value: 0
      1: text: (-> i18n.t('weaponRogue1Text')), notes: (-> i18n.t('weaponRogue1Notes', {str: 2})), str: 2, value: 20
      2: text: (-> i18n.t('weaponRogue2Text')), notes: (-> i18n.t('weaponRogue2Notes', {str: 3})), str: 3, value: 35
      3: text: (-> i18n.t('weaponRogue3Text')), notes: (-> i18n.t('weaponRogue3Notes', {str: 4})), str: 4, value: 50
      4: text: (-> i18n.t('weaponRogue4Text')), notes: (-> i18n.t('weaponRogue4Notes', {str: 6})), str: 6, value: 70
      5: text: (-> i18n.t('weaponRogue5Text')), notes: (-> i18n.t('weaponRogue5Notes', {str: 8})), str: 8, value: 90
      6: text: (-> i18n.t('weaponRogue6Text')), notes: (-> i18n.t('weaponRogue6Notes', {str: 10})), str: 10, value: 120, last: true
    wizard:
      0: twoHanded: true, text: (-> i18n.t('weaponWizard0Text')), notes: (-> i18n.t('weaponWizard0Notes')), value:0
      1: twoHanded: true, text: (-> i18n.t('weaponWizard1Text')), notes: (-> i18n.t('weaponWizard1Notes', {int: 3, per: 1})), int: 3, per: 1, value:30
      2: twoHanded: true, text: (-> i18n.t('weaponWizard2Text')), notes: (-> i18n.t('weaponWizard2Notes', {int: 6, per: 2})), int: 6, per: 2, value:50
      3: twoHanded: true, text: (-> i18n.t('weaponWizard3Text')), notes: (-> i18n.t('weaponWizard3Notes', {int: 9, per: 3})), int: 9, per: 3, value:80
      4: twoHanded: true, text: (-> i18n.t('weaponWizard4Text')), notes: (-> i18n.t('weaponWizard4Notes', {int: 12, per: 5})), int:12, per: 5, value:120
      5: twoHanded: true, text: (-> i18n.t('weaponWizard5Text')), notes: (-> i18n.t('weaponWizard5Notes', {int: 15, per: 7})), int: 15, per: 7, value:160
      6: twoHanded: true, text: (-> i18n.t('weaponWizard6Text')), notes: (-> i18n.t('weaponWizard6Notes', {int: 18, per: 10})), int: 18, per: 10, value:200, last: true
    healer:
      0: text: (-> i18n.t('weaponHealer0Text')), notes: (-> i18n.t('weaponHealer0Notes')), value:0
      1: text: (-> i18n.t('weaponHealer1Text')), notes: (-> i18n.t('weaponHealer1Notes', {int: 2})), int: 2, value:20
      2: text: (-> i18n.t('weaponHealer2Text')), notes: (-> i18n.t('weaponHealer2Notes', {int: 3})), int: 3, value:30
      3: text: (-> i18n.t('weaponHealer3Text')), notes: (-> i18n.t('weaponHealer3Notes', {int: 5})), int: 5, value:45
      4: text: (-> i18n.t('weaponHealer4Text')), notes: (-> i18n.t('weaponHealer4Notes', {int: 7})), int:7, value:65
      5: text: (-> i18n.t('weaponHealer5Text')), notes: (-> i18n.t('weaponHealer5Notes', {int: 9})), int: 9, value:90
      6: text: (-> i18n.t('weaponHealer6Text')), notes: (-> i18n.t('weaponHealer6Notes', {int: 11})), int: 11, value:120, last: true
    special:
      0: text: (-> i18n.t('weaponSpecial0Text')), notes: (-> i18n.t('weaponSpecial0Notes', {str: 20})), str: 20, value:150, canOwn: ((u)-> +u.backer?.tier >= 70)
      1: text: (-> i18n.t('weaponSpecial1Text')), notes: (-> i18n.t('weaponSpecial1Notes', {attrs: 6})), str: 6, per: 6, con: 6, int: 6, value:170, canOwn: ((u)-> +u.contributor?.level >= 4)
      2: text: (-> i18n.t('weaponSpecial2Text')), notes: (-> i18n.t('weaponSpecial2Notes', {attrs: 25})), str: 25, per: 25, value:200, canOwn: ((u)-> +u.backer?.tier >= 300)
      3: text: (-> i18n.t('weaponSpecial3Text')), notes: (-> i18n.t('weaponSpecial3Notes', {attrs: 17})), str: 17, int: 17, con: 17, value:200, canOwn: ((u)-> +u.backer?.tier >= 300)
      critical: text: (-> i18n.t('weaponSpecialCriticalText')), notes: (-> i18n.t('weaponSpecialCriticalNotes', {attrs: 40})), str: 40, per: 40, value:200, canOwn: ((u)-> !!u.contributor?.critical)
      # Winter event gear
      yeti:       event: events.winter, canOwn: ((u)->u.stats.class is 'warrior' ), text: (-> i18n.t('weaponSpecialYetiText')), notes: (-> i18n.t('weaponSpecialYetiNotes', {str: 15})), str: 15, value:90
      ski:        event: events.winter, canOwn: ((u)->u.stats.class is 'rogue'   ), text: (-> i18n.t('weaponSpecialSkiText')), notes: (-> i18n.t('weaponSpecialSkiNotes', {str: 8})), str: 8, value: 90
      candycane:  event: events.winter, canOwn: ((u)->u.stats.class is 'wizard'  ), twoHanded: true, text: (-> i18n.t('weaponSpecialCandycaneText')), notes: (-> i18n.t('weaponSpecialCandycaneNotes', {int: 15, per: 7})), int: 15, per: 7, value:160
      snowflake:  event: events.winter, canOwn: ((u)->u.stats.class is 'healer'  ), text: (-> i18n.t('weaponSpecialSnowflakeText')), notes: (-> i18n.t('weaponSpecialSnowflakeNotes', {int: 9})), int: 9, value:90
      #Spring Fling
      springRogue:    event: events.spring, specialClass: 'rogue',   text: 'Hook Claws', notes: 'Great for scaling tall buildings, and also for shredding carpets. Adds 8 points to STR. Limited Edition 2014 Spring Gear.', value: 80, str: 8
      springWarrior:  event: events.spring, specialClass: 'warrior', text: 'Carrot Sword', notes: 'This mighty sword can slice foes with ease! It also makes a delicious mid-battle snack. Adds 15 points to STR. Limited Edition 2014 Spring Gear.', value: 90, str: 15
      springMage:     event: events.spring, specialClass: 'wizard',  twoHanded:true, text: 'Swiss Cheese Staff', notes: 'Only the most powerful rodents can brave their hunger to wield this potent staff. Adds 15 points to INT and 7 points to PER. Limited Edition 2014 Spring Gear.', value: 160, int:15, per:7
      springHealer:   event: events.spring, specialClass: 'healer',  text: 'Lovely Bone', notes: 'FETCH! Adds 9 points to INT. Limited Edition 2014 Spring Gear.', value: 90, int: 9

  armor:
    base:
      0: text: (-> i18n.t('armorBase0Text')), notes: (-> i18n.t('armorBase0Notes')), value:0
    warrior:
      #0: text: "Plain Clothing", notes:'Ordinary clothing. Confers no benefit.', value:0
      1: text: (-> i18n.t('armorWarrior1Text')), notes: (-> i18n.t('armorWarrior1Notes', {con: 3})), con: 3, value:30
      2: text: (-> i18n.t('armorWarrior2Text')), notes: (-> i18n.t('armorWarrior2Notes', {con: 5})), con: 5, value:45
      3: text: (-> i18n.t('armorWarrior3Text')), notes: (-> i18n.t('armorWarrior3Notes', {con: 7})), con: 7, value:65
      4: text: (-> i18n.t('armorWarrior4Text')), notes: (-> i18n.t('armorWarrior4Notes', {con: 9})), con: 9, value:90
      5: text: (-> i18n.t('armorWarrior5Text')), notes: (-> i18n.t('armorWarrior5Notes', {con: 11})), con: 11, value:120, last: true
    rogue:
      #0: text: "Plain Clothing", notes:'Ordinary clothing. Confers no benefit.', value:0
      1: text: (-> i18n.t('armorRogue1Text')), notes: (-> i18n.t('armorRogue1Notes', {per: 6})), per: 6, value:30
      2: text: (-> i18n.t('armorRogue2Text')), notes: (-> i18n.t('armorRogue2Notes', {per: 9})), per: 9, value:45
      3: text: (-> i18n.t('armorRogue3Text')), notes: (-> i18n.t('armorRogue3Notes', {per: 12})), per: 12, value:65
      4: text: (-> i18n.t('armorRogue4Text')), notes: (-> i18n.t('armorRogue4Notes', {per: 15})), per: 15, value:90
      5: text: (-> i18n.t('armorRogue5Text')), notes: (-> i18n.t('armorRogue5Notes', {per: 18})), per: 18, value:120, last: true
    wizard:
      #0: text: "Apprentice Garb", notes:'For students of magic. Confers no benefit.', value:0
      1: text: (-> i18n.t('armorWizard1Text')), notes: (-> i18n.t('armorWizard1Notes', {int: 2})), int: 2, value:30
      2: text: (-> i18n.t('armorWizard2Text')), notes: (-> i18n.t('armorWizard2Notes', {int: 4})), int: 4, value:45
      3: text: (-> i18n.t('armorWizard3Text')), notes: (-> i18n.t('armorWizard3Notes', {int: 6})), int: 6, value:65
      4: text: (-> i18n.t('armorWizard4Text')), notes: (-> i18n.t('armorWizard4Notes', {int: 9})), int: 9, value:90
      5: text: (-> i18n.t('armorWizard5Text')), notes: (-> i18n.t('armorWizard5Notes', {int: 12})), int: 12, value:120, last: true
    healer:
      #0: text: "Novice Robe", notes:'For healers in training. Confers no benefit.', value:0
      1: text: (-> i18n.t('armorHealer1Text')), notes: (-> i18n.t('armorHealer1Notes', {con: 6})), con: 6, value:30
      2: text: (-> i18n.t('armorHealer2Text')), notes: (-> i18n.t('armorHealer2Notes', {con: 9})), con: 9, value:45
      3: text: (-> i18n.t('armorHealer3Text')), notes: (-> i18n.t('armorHealer3Notes', {con: 12})), con: 12, value:65
      4: text: (-> i18n.t('armorHealer4Text')), notes: (-> i18n.t('armorHealer4Notes', {con: 15})), con: 15, value:90
      5: text: (-> i18n.t('armorHealer5Text')), notes: (-> i18n.t('armorHealer5Notes', {con: 18})), con: 18, value:120, last: true
    special:
      0: text: (-> i18n.t('armorSpecial0Text')), notes: (-> i18n.t('armorSpecial0Notes', {con: 20})), con: 20, value:150, canOwn: ((u)-> +u.backer?.tier >= 45)
      1: text: (-> i18n.t('armorSpecial1Text')), notes: (-> i18n.t('armorSpecial1Notes', {attrs: 6})), con: 6, str: 6, per: 6, int: 6, value:170, canOwn: ((u)-> +u.contributor?.level >= 2)
      2: text: (-> i18n.t('armorSpecial2Text')), notes: (-> i18n.t('armorSpecial2Notes', {attrs: 25})), int: 25, con: 25, value:200, canOwn: ((u)-> +u.backer?.tier >= 300)
      #Winter event
      yeti:       event: events.winter, canOwn: ((u)->u.stats.class is 'warrior' ), text: (-> i18n.t('armorSpecialYetiText')), notes: (-> i18n.t('armorSpecialYetiNotes', {con: 9})), con: 9, value:90
      ski:        event: events.winter, canOwn: ((u)->u.stats.class is 'rogue'   ), text: (-> i18n.t('armorSpecialSkiText')), notes: (-> i18n.t('armorSpecialSkiText', {per: 15})), per: 15, value:90
      candycane:  event: events.winter, canOwn: ((u)->u.stats.class is 'wizard'  ), text: (-> i18n.t('armorSpecialCandycaneText')), notes: (-> i18n.t('armorSpecialCandycaneNotes', {int: 9})), int: 9, value:90
      snowflake:  event: events.winter, canOwn: ((u)->u.stats.class is 'healer'  ), text: (-> i18n.t('armorSpecialSnowflakeText')), notes: (-> i18n.t('armorSpecialSnowflakeNotes', {con: 15})), con: 15, value:90
      birthday:   event: events.birthday, text: (-> i18n.t('armorSpecialBirthdayText')), notes: (-> i18n.t('armorSpecialBirthdayNotes')), value: 0
      # Spring Fling
      springRogue:    event: events.spring, specialClass: 'rogue',   text: 'Sleek Cat Suit', notes: 'Impeccably groomed. Adds 15 points to PER. Limited Edition 2014 Spring Gear.', value: 90, per: 15
      springWarrior:  event: events.spring, specialClass: 'warrior', text: 'Clover-steel Armor', notes: 'Soft as clover, strong as steel! Adds 9 points to CON. Limited Edition 2014 Spring Gear.', value: 90, con: 9
      springMage:     event: events.spring, specialClass: 'wizard',    text: 'Rodentia Robes', notes: 'Mice are nice! Adds 9 points to INT. Limited Edition 2014 Spring Gear.', value: 90, int: 9
      springHealer:   event: events.spring, specialClass: 'healer',  text: 'Fuzzy Puppy Robes', notes: 'Warm and snuggly, but protects its owner from harm. Adds 15 points to CON. Limited Edition 2014 Spring Gear.', value: 90, con: 15
    mystery:
      201402: text: 'Messenger Robes', notes: "Shimmering and strong, these robes have many pockets to carry letters.", mystery:mystery['201402'], value: 10
      201403: text: 'Forest Walker Armor', notes: "This mossy armor of woven wood bends with the movement of the wearer.", mystery:mystery['201403'], value: 10

  head:
    base:
      0: text: (-> i18n.t('headBase0Text')), notes: (-> i18n.t('headBase0Notes')), value:0
    warrior:
      #0: text: "No Helm", notes:'No headgear.', value:0
      1: text: (-> i18n.t('headWarrior1Text')), notes: (-> i18n.t('headWarrior1Notes', {str: 2})), str: 2, value:15
      2: text: (-> i18n.t('headWarrior2Text')), notes: (-> i18n.t('headWarrior2Notes', {str: 4})), str: 4, value:25
      3: text: (-> i18n.t('headWarrior3Text')), notes: (-> i18n.t('headWarrior3Notes', {str: 6})), str: 6, value:40
      4: text: (-> i18n.t('headWarrior4Text')), notes: (-> i18n.t('headWarrior4Notes', {str: 9})), str: 9, value:60
      5: text: (-> i18n.t('headWarrior5Text')), notes: (-> i18n.t('headWarrior5Notes', {str: 12})), str: 12, value:80, last: true
    rogue:
      #0: text: "No Hood", notes:'No headgear.', value:0
      1: text: (-> i18n.t('headRogue1Text')), notes: (-> i18n.t('headRogue1Notes', {per: 2})), per: 2, value:15
      2: text: (-> i18n.t('headRogue2Text')), notes: (-> i18n.t('headRogue2Notes', {per: 4})), per: 4, value:25
      3: text: (-> i18n.t('headRogue3Text')), notes: (-> i18n.t('headRogue3Notes', {per: 6})), per: 6, value:40
      4: text: (-> i18n.t('headRogue4Text')), notes: (-> i18n.t('headRogue4Notes', {per: 9})), per: 9, value:60
      5: text: (-> i18n.t('headRogue5Text')), notes: (-> i18n.t('headRogue5Notes', {per: 12})), per: 12, value:80, last: true
    wizard:
      #0: text: "No Hat", notes:'No headgear.', value:0
      1: text: (-> i18n.t('headWizard1Text')), notes: (-> i18n.t('headWizard1Notes', {per: 2})), per: 2, value:15
      2: text: (-> i18n.t('headWizard2Text')), notes: (-> i18n.t('headWizard2Notes', {per: 3})), per: 3, value:25
      3: text: (-> i18n.t('headWizard3Text')), notes: (-> i18n.t('headWizard3Notes', {per: 5})), per: 5, value:40
      4: text: (-> i18n.t('headWizard4Text')), notes: (-> i18n.t('headWizard4Notes', {per: 7})), per: 7, value:60
      5: text: (-> i18n.t('headWizard5Text')), notes: (-> i18n.t('headWizard5Notes', {per: 10})), per: 10, value:80, last: true
    healer:
      #0: text: "No Circlet", notes:'No headgear.', value:0
      1: text: (-> i18n.t('headHealer1Text')), notes: (-> i18n.t('headHealer1Notes', {int: 2})), int: 2, value:15
      2: text: (-> i18n.t('headHealer2Text')), notes: (-> i18n.t('headHealer2Notes', {int: 3})), int: 3, value:25
      3: text: (-> i18n.t('headHealer3Text')), notes: (-> i18n.t('headHealer3Notes', {int: 5})), int: 5, value:40
      4: text: (-> i18n.t('headHealer4Text')), notes: (-> i18n.t('headHealer4Notes', {int: 7})), int: 7, value:60
      5: text: (-> i18n.t('headHealer5Text')), notes: (-> i18n.t('headHealer5Notes', {int: 9})), int: 9, value:80, last: true
    special:
      0: text: (-> i18n.t('headSpecial0Text')), notes: (-> i18n.t('headSpecial0Notes', {int: 20})), int: 20, value:150, canOwn: ((u)-> +u.backer?.tier >= 45)
      1: text: (-> i18n.t('headSpecial1Text')), notes: (-> i18n.t('headSpecial1Notes', {attrs: 6})), con: 6, str: 6, per: 6, int: 6, value:170, canOwn: ((u)-> +u.contributor?.level >= 3)
      2: text: (-> i18n.t('headSpecial2Text')), notes: (-> i18n.t('headSpecial2Notes', {attrs: 25})), int: 25, str: 25, value:200, canOwn: ((u)-> +u.backer?.tier >= 300)
      #Winter event
      nye:        event: events.winter, text: (-> i18n.t('headSpecialNyeText')), notes: (-> i18n.t('headSpecialNyeNotes')), value: 0
      yeti:       event: events.winter, canOwn: ((u)->u.stats.class is 'warrior' ), text: (-> i18n.t('headSpecialYetiText')), notes: (-> i18n.t('headSpecialYetiNotes', {str: 9})), str: 9, value:60
      ski:        event: events.winter, canOwn: ((u)->u.stats.class is 'rogue'   ), text: (-> i18n.t('headSpecialSkiText')), notes: (-> i18n.t('headSpecialSkiNotes', {per: 9})), per: 9, value:60
      candycane:  event: events.winter, canOwn: ((u)->u.stats.class is 'wizard'  ), text: (-> i18n.t('headSpecialCanycaneText')), notes: (-> i18n.t('headSpecialCanycaneNotes', {per: 7})), per: 7, value:60
      snowflake:  event: events.winter, canOwn: ((u)->u.stats.class is 'healer'  ), text: (-> i18n.t('headSpecialSnowflakeText')), notes: (-> i18n.t('headSpecialSnowflakeNotes', {int: 7})), int: 7, value:60
      # Spring Fling
      springRogue:    event: events.spring, specialClass: 'rogue',   text:'Stealthy Kitty Mask', notes:'Nobody will EVER guess that you are a cat burglar! Adds 9 points to PER. Limited Edition 2014 Spring Gear.',value: 40,per: 9
      springWarrior:  event: events.spring, specialClass: 'warrior', text:'Clover-steel Helmet', notes:'Welded from sweet meadow clover, this helmet can resist even the mightiest blow. Adds 9 points to STR. Limited Edition 2014 Spring Gear.',value: 40,str: 9
      springMage:     event: events.spring, specialClass: 'wizard',    text:'Swiss Cheese Hat', notes:'This hat stores lots of powerful magic! Try not to nibble it. Adds 7 points to PER. Limited Edition 2014 Spring Gear.',value: 40,per: 7
      springHealer:   event: events.spring, specialClass: 'healer',  text:'Crown of Friendship', notes:"This crown symbolizes loyalty and companionship. A dog is an adventurer's best friend, after all! Adds 7 points to INT. Limited Edition 2014 Spring Gear.", value: 40, int: 7
    mystery:
      201402: text: 'Winged Helm', notes: "This winged circlet imbues the wearer with the speed of the wind!", mystery:mystery['201402'], value: 10

  shield:
    base:
      0: text: (-> i18n.t('shieldBase0Text')), notes: (-> i18n.t('shieldBase0Notes')), value:0
      #changed because this is what shows up for all classes, including those without shields
    warrior:
      #0: text: "No Shield", notes:'No shield.', value:0
      1: text: (-> i18n.t('shieldWarrior1Text')), notes: (-> i18n.t('shieldWarrior1Notes', {con: 2})), con: 2, value:20
      2: text: (-> i18n.t('shieldWarrior2Text')), notes: (-> i18n.t('shieldWarrior2Notes', {con: 3})), con: 3, value:35
      3: text: (-> i18n.t('shieldWarrior3Text')), notes: (-> i18n.t('shieldWarrior3Notes', {con: 5})), con: 5, value:50
      4: text: (-> i18n.t('shieldWarrior4Text')), notes: (-> i18n.t('shieldWarrior4Notes', {con: 7})), con: 7, value:70
      5: text: (-> i18n.t('shieldWarrior5Text')), notes: (-> i18n.t('shieldWarrior5Notes', {con: 9})), con: 9, value:90, last: true
    rogue:
      0: text: (-> i18n.t('weaponRogue0Text')), notes: (-> i18n.t('weaponRogue0Notes')), str: 0, value: 0
      1: text: (-> i18n.t('weaponRogue1Text')), notes: (-> i18n.t('weaponRogue1Notes', {str: 2})), str: 2, value: 20
      2: text: (-> i18n.t('weaponRogue2Text')), notes: (-> i18n.t('weaponRogue2Notes', {str: 3})), str: 3, value: 35
      3: text: (-> i18n.t('weaponRogue3Text')), notes: (-> i18n.t('weaponRogue3Notes', {str: 4})), str: 4, value: 50
      4: text: (-> i18n.t('weaponRogue4Text')), notes: (-> i18n.t('weaponRogue4Notes', {str: 6})), str: 6, value: 70
      5: text: (-> i18n.t('weaponRogue5Text')), notes: (-> i18n.t('weaponRogue5Notes', {str: 8})), str: 8, value: 90
      6: text: (-> i18n.t('weaponRogue6Text')), notes: (-> i18n.t('weaponRogue6Notes', {str: 10})), str: 10, value: 120, last: true
    wizard: {}
      #0: text: "No Shield", notes:'No shield.', def: 0, value:0, last: true
    healer:
      #0: text: "No Shield", notes:'No shield.', def: 0, value:0
      1: text: (-> i18n.t('shieldHealer1Text')), notes: (-> i18n.t('shieldHealer1Notes', {con: 2})), con: 2, value:20
      2: text: (-> i18n.t('shieldHealer2Text')), notes: (-> i18n.t('shieldHealer2Notes', {con: 4})), con: 4, value:35
      3: text: (-> i18n.t('shieldHealer3Text')), notes: (-> i18n.t('shieldHealer3Notes', {con: 6})), con: 6, value:50
      4: text: (-> i18n.t('shieldHealer4Text')), notes: (-> i18n.t('shieldHealer4Notes', {con: 9})), con: 9, value:70
      5: text: (-> i18n.t('shieldHealer5Text')), notes: (-> i18n.t('shieldHealer5Notes', {con: 12})), con: 12, value:90, last: true
    special:
      0: text: (-> i18n.t('shieldSpecial0Text')), notes: (-> i18n.t('shieldSpecial0Notes', {per: 20})), per: 20, value:150, canOwn: ((u)-> +u.backer?.tier >= 45)
      1: text: (-> i18n.t('shieldSpecial1Text')), notes: (-> i18n.t('shieldSpecial1Notes', {attrs: 6})), con: 6, str: 6, per: 6, int:6, value:170, canOwn: ((u)-> +u.contributor?.level >= 5)
      #Winter event
      yeti:       event: events.winter, canOwn: ((u)->u.stats.class is 'warrior' ), text: (-> i18n.t('shieldSpecialYetiText')), notes: (-> i18n.t('shieldSpecialYetiNotes', {con: 7})), con: 7, value: 70
      ski:        event: events.winter, canOwn: ((u)->u.stats.class is 'rogue'   ), text: (-> i18n.t('shieldSpecialSkiText')), notes: (-> i18n.t('shieldSpecialSkiNotes', {str: 8})), str: 8, value: 90
      snowflake:  event: events.winter, canOwn: ((u)->u.stats.class is 'healer'  ), text: (-> i18n.t('shieldSpecialSnowflakeText')), notes: (-> i18n.t('shieldSpecialSnowflakeNotes', {con: 9})), con: 9, value: 70
      #Spring Fling
      springRogue:    event: events.spring, specialClass: 'rogue',   text: 'Hook Claws', notes:'Great for scaling tall buildings, and also for shredding carpets. Adds 8 points to STR. Limited Edition 2014 Spring Gear.', value: 80, str: 8
      springWarrior:  event: events.spring, specialClass: 'warrior', text: 'Egg Shield', notes: "This shield never cracks, no matter how hard you hit it! Adds 7 points to CON. Limited Edition 2014 Spring Gear.", value: 70, con: 7
      springHealer:   event: events.spring, specialClass: 'healer',  text: 'Squeaky Ball of Ultimate Protection', notes: "Lets out an obnoxious, continuous squeak when bitten, driving enemies away. Adds 9 points to CON. Limited Edition 2014 Spring Gear.", value: 70, con: 9

  back:
    base:
      0: text: (-> i18n.t('backBase0Text')), notes: (-> i18n.t('backBase0Notes')), value:0
    mystery:
      201402: text: 'Golden Wings', notes: "These shining wings have feathers that glitter in the sun!", mystery:mystery['201402'], value: 10

  headAccessory:
    base:
      0: text: 'No Head Accessory', notes: 'No Head Accessory', value: 0, last: true
    special:
      # Spring Event
      springRogue:   event: events.spring, specialClass: 'rogue',   text: "Purple Cat Ears", notes: "These feline ears twitch to detect incoming threats. Confers no stat bonus. Limited Edition 2014 Spring Gear.", value: 20
      springWarrior: event: events.spring, specialClass: 'warrior', text: 'Green Bunny Ears', notes: "Bunny ears that keenly detect every crunch of a carrot. Confers no status bonus. Limited Edition 2014 Spring Gear.", value: 20
      springMage:    event: events.spring, specialClass: 'wizard',    text: 'Blue Mouse Ears', notes: 'These round mouse ears are silky-soft. Confers no stat bonus. Limited Edition 2014 Spring Gear.', value: 20
      springHealer:  event: events.spring, specialClass: 'healer',  text: 'Yellow Dog Ears', notes: 'Floppy but cute. Wanna play? Confers no stat bonus. Limited Edition 2014 Spring Gear.', value: 20
    mystery:
      201403: text: 'Forest Walker Antlers', notes: "These antlers shimmer with moss and lichen.", mystery:mystery['201403'], value: 10

###
  The gear is exported as a tree (defined above), and a flat list (eg, {weapon_healer_1: .., shield_special_0: ...}) since
  they are needed in different froms at different points in the app
###
api.gear =
  tree: gear
  flat: {}

_.each gearTypes, (type) ->
  _.each classes.concat(['base', 'special', 'mystery']), (klass) ->
    # add "type" to each item, so we can reference that as "weapon" or "armor" in the html
    _.each gear[type][klass], (item, i) ->
      key = "#{type}_#{klass}_#{i}"
      _.defaults item, {type, key, klass, index: i, str:0, int:0, per:0, con:0}

      if item.event
        #? indicates null/undefined. true means they own currently, false means they once owned - and false is what we're
        # after (they can buy back if they bought it during the event's timeframe)
        _canOwn = item.canOwn or (->true)
        item.canOwn = (u)->
          _canOwn(u) and
            (u.items.gear.owned[key]? or (moment().isAfter(item.event.start) and moment().isBefore(item.event.end))) and
            (if item.specialClass then (u.stats.class is item.specialClass) else true)

      if item.mystery
        item.canOwn = (u)-> u.items.gear.owned[key]?

      api.gear.flat[key] = item

###
  ---------------------------------------------------------------
  Potion
  ---------------------------------------------------------------
###

api.potion = type: 'potion', text: (-> i18n.t('potionText')), notes: (-> i18n.t('potionNotes')), value: 25, key: 'potion'

###
   ---------------------------------------------------------------
   Classes
   ---------------------------------------------------------------
###

api.classes = classes

###
   ---------------------------------------------------------------
   Gear Types
   ---------------------------------------------------------------
###

api.gearTypes = gearTypes

###
  ---------------------------------------------------------------
  Spells
  ---------------------------------------------------------------
  Text, notes, and mana are obvious. The rest:

  * {target}: one of [task, self, party, user]. This is very important, because if the cast() function is expecting one
    thing and receives another, it will cause errors. `self` is used for self buffs, multi-task debuffs, AOEs (eg, meteor-shower),
    etc. Basically, use self for anything that's not [task, party, user] and is an instant-cast

  * {cast}: the function that's run to perform the ability's action. This is pretty slick - because this is exported to the
    web, this function can be performed on the client and on the server. `user` param is self (needed for determining your
    own stats for effectiveness of cast), and `target` param is one of [task, party, user]. In the case of `self` spells,
    you act on `user` instead of `target`. You can trust these are the correct objects, as long as the `target` attr of the
    spell is correct. Take a look at habitrpg/src/models/user.js and habitrpg/src/models/task.js for what attributes are
    available on each model. Note `task.value` is its "redness". If party is passed in, it's an array of users,
    so you'll want to iterate over them like: `_.each(target,function(member){...})`

  Note, user.stats.mp is docked after automatically (it's appended to functions automatically down below in an _.each)
###

#
diminishingReturns = (bonus, max, halfway=max/2) -> max*(bonus/(bonus+halfway))

api.spells =

  wizard:
    fireball:
      text: 'Burst of Flames'
      mana: 10
      lvl: 11
      target: 'task'
      notes: 'With a crack, flames burst from your staff, scorching a task. You deal high damage to the task, and gain additional experience (more experience for greens).'
      cast: (user, target) ->
        # I seriously have no idea what I'm doing here. I'm just mashing buttons until numbers seem right-ish. Anyone know math?
        bonus = user._statsComputed.int * user.fns.crit('per')
        target.value += diminishingReturns(bonus*.02, 4)
        bonus *= Math.ceil ((if target.value < 0 then 1 else target.value+1) *.075)
        #console.log {bonus, expBonus:bonus,upBonus:bonus*.1}
        user.stats.exp += diminishingReturns(bonus,75)
        user.party.quest.progress.up += diminishingReturns(bonus*.1,50,30) if user.party.quest.key

    mpheal:
      text: 'Ethereal Surge'
      mana: 30
      lvl: 12
      target: 'party'
      notes: "A flow of magical energy rushes from your hands and recharges your party. Your party recovers MP.",
      cast: (user, target)->
        _.each target, (member) ->
          bonus = Math.ceil(user._statsComputed.int * .1)
          bonus = 25 if bonus > 25 #prevent ability to replenish own mp infinitely
          member.stats.mp += bonus

    earth:
      text: 'Earthquake'
      mana: 35
      lvl: 13
      target: 'party'
      notes: "The ground below your party's tasks cracks and shakes with extreme intensity, slowing them down and opening them up to more attacks. Your party gains a buff to experience.",
      cast: (user, target) ->
        _.each target, (member) ->
          member.stats.buffs.int ?= 0
          member.stats.buffs.int += Math.ceil(user._statsComputed.int * .05)

    frost:
      text: 'Chilling Frost'
      mana: 40
      lvl: 14
      target: 'self'
      notes: "Ice erupts from every surface, swallowing your tasks and freezing them in place. Your dailies' streaks won't reset at the end of the day."
      cast: (user, target) ->
        user.stats.buffs.streaks = true

  warrior:
    smash:
      text: 'Brutal Smash'
      mana: 10
      lvl: 11
      target: 'task'
      notes: "You savagely hit a single task with all of your might, beating it into submission. The task's redness decreases."
      cast: (user, target) ->
        target.value += 2.5 * (user._statsComputed.str / (user._statsComputed.str + 50)) * user.fns.crit('per')
        user.party.quest.progress.up += Math.ceil(user._statsComputed.str * .2) if user.party.quest.key
    defensiveStance:
      text: 'Defensive Stance'
      mana: 25
      lvl: 12
      target: 'self'
      notes: "You take a moment to relax your body and enter a defensive stance to ready yourself for the tasks' next onslaught. Reduces damage from dailies at the end of the day."
      cast: (user, target) ->
        user.stats.buffs.con ?= 0
        user.stats.buffs.con += Math.ceil(user._statsComputed.con * .05)
    valorousPresence:
      text: 'Valorous Presence'
      mana: 20
      lvl: 13
      target: 'party'
      notes: "Your presence emboldens the party. Their newfound courage gives them a boost of strength. Party members gain a buff to their STR."
      cast: (user, target) ->
        _.each target, (member) ->
          member.stats.buffs.str ?= 0
          member.stats.buffs.str += Math.ceil(user._statsComputed.str * .05)
    intimidate:
      text: 'Intimidating Gaze'
      mana: 15
      lvl: 14
      target: 'party'
      notes: "Your gaze strikes fear into the hearts of your party's enemies. The party gains a moderate boost to defense."
      cast: (user, target) ->
        _.each target, (member) ->
          member.stats.buffs.con ?= 0
          member.stats.buffs.con += Math.ceil(user._statsComputed.con *  .03)

  rogue:
    pickPocket:
      text: 'Pickpocket'
      mana: 10
      lvl: 11
      target: 'task'
      notes: "Your nimble fingers run through the task's pockets and find some treasures for yourself. You gain an increased gold bonus on the task, higher yet the 'fatter' (bluer) your task."
      cast: (user, target) ->
        bonus = (if target.value < 0 then 1 else target.value+2) + (user._statsComputed.per * 0.5)
        user.stats.gp += 25 * (bonus / (bonus + 75))
    backStab:
      text: 'Backstab'
      mana: 15
      lvl: 12
      target: 'task'
      notes: "Without a sound, you sweep behind a task and stab it in the back. You deal higher damage to the task, with a higher chance of a critical hit."
      cast: (user, target) ->
        _crit = user.fns.crit('per', .3)
        target.value += _crit * .03
        bonus =  (if target.value < 0 then 1 else target.value+1) * _crit
        user.stats.exp += bonus
        user.stats.gp += bonus
        # user.party.quest.progress.up += bonus if user.party.quest.key # remove hurting bosses for rogues, seems OP for now
    toolsOfTrade:
      text: 'Tools of the Trade'
      mana: 25
      lvl: 13
      target: 'party'
      notes: "You share your thievery tools with the party to aid them in 'acquiring' more gold. The party's gold bonus for tasks and chance of drops is buffed for a day."
      cast: (user, target) ->
        ## lasts 24 hours ##
        _.each target, (member) ->
          member.stats.buffs.per ?= 0
          member.stats.buffs.per += Math.ceil(user._statsComputed.per * .03)
    stealth:
      text: 'Stealth'
      mana: 45
      lvl: 14
      target: 'self'
      notes: "You duck into the shadows, pulling up your hood. Many dailies won't find you this night; fewer yet the higher your Perception."
      cast: (user, target) ->
        user.stats.buffs.stealth ?= 0
        ## scales to user's # of dailies; maxes out at 100% at 100 per ##
        user.stats.buffs.stealth += Math.ceil(user.dailys.length * user._statsComputed.per / 100)

  healer:
    heal:
      text: 'Healing Light'
      mana: 15
      lvl: 11
      target: 'self'
      notes: 'Light covers your body, healing your wounds. You gain a boost to your health.'
      cast: (user, target) ->
        user.stats.hp += (user._statsComputed.con + user._statsComputed.int + 5) * .075
        user.stats.hp = 50 if user.stats.hp > 50
    brightness:
      text: 'Searing Brightness'
      mana: 15
      lvl: 12
      target: 'self'
      notes: "You cast a burst of light that blinds all of your tasks. The redness of your tasks is reduced."
      cast: (user, target) ->
        _.each user.tasks, (target) ->
          return if target.type is 'reward'
          target.value += 1.5 * (user._statsComputed.int / (user._statsComputed.int + 40))
    protectAura:
      text: 'Protective Aura'
      mana: 30
      lvl: 13
      target: 'party'
      notes: "A magical aura surrounds your party members, protecting them from damage. Your party members gain a buff to their defense."
      cast: (user, target) ->
        ## lasts 24 hours ##
        _.each target, (member) ->
          member.stats.buffs.con ?= 0
          member.stats.buffs.con += Math.ceil(user._statsComputed.con * .15)
    heallAll:
      text: 'Blessing'
      mana: 25
      lvl: 14
      target: 'party'
      notes: "Soothing light envelops your party and heals them of their injuries. Your party members gain a boost to their health."
      cast: (user, target) ->
        _.each target, (member) ->
          member.stats.hp += (user._statsComputed.con + user._statsComputed.int + 5) * .04
          member.stats.hp = 50 if member.stats.hp > 50

  special:
    snowball:
      text: 'Snowball'
      mana: 0
      value: 1
      target: 'user'
      notes: "Throw a snowball at a party member, what could possibly go wrong? Lasts until member's new day."
      cast: (user, target) ->
        target.stats.buffs.snowball = true
        target.achievements.snowball ?= 0
        target.achievements.snowball++
        user.items.special.snowball--

    salt:
      text: 'Salt'
      mana: 0
      value: 5
      target: 'self'
      notes: 'Someone has snowballed you. Ha ha, very funny. Now get this snow off me!'
      cast: (user, target) ->
        user.stats.buffs.snowball = false
        user.stats.gp -= 5

# Intercept all spells to reduce user.stats.mp after casting the spell
_.each api.spells, (spellClass) ->
  _.each spellClass, (spell, key) ->
    spell.key = key
    _cast = spell.cast
    spell.cast = (user, target) ->
      #return if spell.target and spell.target != (if target.type then 'task' else 'user')
      _cast(user,target)
      user.stats.mp -= spell.mana

api.special = api.spells.special

###
  ---------------------------------------------------------------
  Drops
  ---------------------------------------------------------------
###

api.dropEggs =
  # value & other defaults set below
  Wolf:             text: 'Wolf', adjective: 'loyal'
  TigerCub:         text: 'Tiger Cub', mountText: 'Tiger', adjective: 'fierce'
  PandaCub:         text: 'Panda Cub', mountText: 'Panda', adjective: 'gentle'
  LionCub:          text: 'Lion Cub',  mountText: 'Lion', adjective: 'regal'
  Fox:              text: 'Fox', adjective: 'wily'
  FlyingPig:        text: 'Flying Pig', adjective: 'whimsical'
  Dragon:           text: 'Dragon', adjective: 'mighty'
  Cactus:           text: 'Cactus', adjective: 'prickly'
  BearCub:          text: 'Bear Cub',  mountText: 'Bear', adjective: 'cuddly'
_.each api.dropEggs, (egg,key) ->
  _.defaults egg,
    canBuy:true
    value: 3
    key: key
    notes: "Find a hatching potion to pour on this egg, and it will hatch into a #{egg.adjective} #{egg.text}."
    mountText: egg.text

api.questEggs =
  # value & other defaults set below
  Gryphon:          text: 'Gryphon',  adjective: 'proud', canBuy: false
  Hedgehog:         text: 'Hedgehog', adjective: 'spiky', canBuy: false
  Deer:             text: 'Deer',     adjective: 'elegant', canBuy: false
  Egg:              text: 'Egg',     adjective: 'colorful', canBuy: false
_.each api.questEggs, (egg,key) ->
  _.defaults egg,
    canBuy:false
    value: 3
    key: key
    notes: "Find a hatching potion to pour on this egg, and it will hatch into a #{egg.adjective} #{egg.text}."
    mountText: egg.text

api.eggs = _.assign(_.cloneDeep(api.dropEggs), api.questEggs)

api.specialPets =
  'Wolf-Veteran':   true
  'Wolf-Cerberus':  true
  'Dragon-Hydra':   true
  'Turkey-Base':    true
  'BearCub-Polar':  true

api.specialMounts =
  'BearCub-Polar':	true
  'LionCub-Ethereal':	true

api.hatchingPotions =
  Base:             value: 2, text: 'Base'
  White:            value: 2, text: 'White'
  Desert:           value: 2, text: 'Desert'
  Red:              value: 3, text: 'Red'
  Shade:            value: 3, text: 'Shade'
  Skeleton:         value: 3, text: 'Skeleton'
  Zombie:           value: 4, text: 'Zombie'
  CottonCandyPink:  value: 4, text: 'Cotton Candy Pink'
  CottonCandyBlue:  value: 4, text: 'Cotton Candy Blue'
  Golden:           value: 5, text: 'Golden'
_.each api.hatchingPotions, (pot,key) ->
  _.defaults pot, {key, value: 2, notes: "Pour this on an egg, and it will hatch as a #{pot.text} pet."}

api.pets = _.transform api.dropEggs, (m, egg) ->
  _.defaults m, _.transform api.hatchingPotions, (m2, pot) ->
    m2[egg.key + "-" + pot.key] = true

api.questPets = _.transform api.questEggs, (m, egg) ->
  _.defaults m, _.transform api.hatchingPotions, (m2, pot) ->
    m2[egg.key + "-" + pot.key] = true

api.food =
  Meat:             text: 'Meat', target: 'Base', article: ''
  Milk:             text: 'Milk', target: 'White', article: ''
  Potatoe:          text: 'Potato', target: 'Desert', article: 'a '
  Strawberry:       text: 'Strawberry', target: 'Red', article: 'a '
  Chocolate:        text: 'Chocolate', target: 'Shade', article: ''
  Fish:             text: 'Fish', target: 'Skeleton', article: 'a '
  RottenMeat:       text: 'Rotten Meat', target: 'Zombie', article: ''
  CottonCandyPink:  text: 'Pink Cotton Candy', target: 'CottonCandyPink', article: ''
  CottonCandyBlue:  text: 'Blue Cotton Candy', target: 'CottonCandyBlue', article: ''
  # FIXME what to do with these extra items? Should we add "targets" (plural) for food instead of singular, so we don't have awkward extras?
  #Cheese:           text: 'Cheese', target: 'Golden'
  #Watermelon:       text: 'Watermelon', target: 'Golden'
  #SeaWeed:          text: 'SeaWeed', target: 'Golden'

  Cake_Skeleton:        canBuy: false, text: 'Bare Bones Cake', target: 'Skeleton', article: ''
  Cake_Base:            canBuy: false, text: 'Basic Cake', target: 'Base', article: ''
  Cake_CottonCandyBlue: canBuy: false, text: 'Candy Blue Cake', target: 'CottonCandyBlue', article: ''
  Cake_CottonCandyPink: canBuy: false, text: 'Candy Pink Cake', target: 'CottonCandyPink', article: ''
  Cake_Shade:           canBuy: false, text: 'Chocolate Cake', target: 'Shade', article: ''
  Cake_White:           canBuy: false, text: 'Cream Cake', target: 'White', article: ''
  Cake_Golden:          canBuy: false, text: 'Honey Cake', target: 'Golden', article: ''
  Cake_Zombie:          canBuy: false, text: 'Rotten Cake', target: 'Zombie', article: ''
  Cake_Desert:          canBuy: false, text: 'Sand Cake', target: 'Desert', article: ''
  Cake_Red:             canBuy: false, text: 'Strawberry Cake', target: 'Red', article: ''

  # Tests hack, put honey last so the faux random picks it up in unit tests
  Honey:            text: 'Honey', target: 'Golden', article: ''

  Saddle:           text: 'Saddle', value: 5, notes: 'Instantly raises one of your pets into a mount.'
_.each api.food, (food,key) ->
  _.defaults food, {value: 1, key, notes: "Feed this to a pet and it may grow into a sturdy steed.", canBuy:true}

api.quests =

  evilsanta:
    canBuy:false
    text: "Trapper Santa" # title of the quest (eg, Deep into Vice's Layer)
    notes: "You hear bemoaned roars deep in the icefields. You follow the roars and growls - punctuated by another voice's cackling - to a clearing in the woods where you see a fully-grown polar bear. She's caged and shackled, roaring for life. Dancing atop the cage is a malicious little imp wearing castaway Christmas costumes. Vanquish Trapper Santa, and save the beast!"
    completion: "Trapper Santa squeals in anger, and bounces off into the night. A grateful she-bear, through roars and growls, tries to tell you something. You take her back to the stables, where Matt Boch the whisperer listens to her tale with a gasp of horror. She has a cub! He ran off into the icefields when mama bear was captured. Help her find her baby!"
    value: 4 # Gem cost to buy, GP sell-back
    #mechanic: enum['perfectDailies', ...]
    boss:
      name: "Trapper Santa" # name of the boss himself (eg, Vice)
      hp: 300
      str: 1 # Multiplier of users' missed dailies
    drop:
      items: [
        {type: 'mounts', key: 'BearCub-Polar', text: "Polar Bear (Mount)"}
      ]
      gp: 20
      exp: 100 # Exp bonus from defeating the boss

  evilsanta2:
    canBuy:false
    text: "Find The Cub"
    notes: "Mama bear's cub had run off into the icefields when she was captured by the trapper. At the edge of the woods, she sniffs the air. You hear twig-snaps and snow crunch through the crystaline sound of the forest. Paw prints! You both start racing to follow the trail. Find all the prints and broken twigs, and retrieve her cub!"
    completion: "You've found the cub! Mama and baby bear couldn't be more grateful. As a token, they've decided to keep you company till the end of days."
    value: 4
    previous: 'evilsanta'
    collect:
      tracks: text: 'Tracks', count: 20
      branches: text: 'Broken Twigs', count: 10
    drop:
      items: [
        {type: 'pets', key: 'BearCub-Polar', text: "Polar Bear (Pet)"}
      ]
      gp: 20
      exp: 100

  gryphon:
    text: "The Fiery Gryphon"
    notes: 'The grand beastmaster, @baconsaur, has come to your party seeking help. "Please, adventurers, you must help me! My prized gryphon has broken free and is terrorizing Habit City! If you can stop her, I could reward you with some of her eggs!"'
    completion: 'Defeated, the mighty beast ashamedly slinks back to its master."My word! Well done, adventurers!" @baconsaur exclaims, "Please, have some of the gryphon\'s eggs. I am sure you will raise these young ones well!'
    value: 4 # Gem cost to buy, GP sell-back
    boss:
      name: "Fiery Gryphon" # name of the boss himself (eg, Vice)
      hp: 300
      str: 1.5 # Multiplier of users' missed dailies
    drop:
      items: [
        {type: 'eggs', key: 'Gryphon', text: "Gryphon (Egg)"}
        {type: 'eggs', key: 'Gryphon', text: "Gryphon (Egg)"}
        {type: 'eggs', key: 'Gryphon', text: "Gryphon (Egg)"}
      ]
      gp: 25
      exp: 125
      
  hedgehog:
    text: "The Hedgebeast"
    notes: 'Hedgehogs are a funny group of animals. They are some of the most affectionate pets a Habiteer could own. But rumor has it, if you feed them milk after midnight, they grow quite irritable. And fifty times their size. And @Inventrix did just that. Oops.'
    completion: 'Your party successfully calmed down the hedgehog! After shrinking down to a normal size, she hobbles away to her eggs. She returns squeaking and nudging some of her eggs along towards your party. Hopefully, these hedgehogs like milk better!'
    value: 4 # Gem cost to buy, GP sell-back
    boss:
      name: "Hedgebeast" # name of the boss himself (eg, Vice)
      hp: 400
      str: 1.25 # Multiplier of users' missed dailies
    drop:
      items: [
        {type: 'eggs', key: 'Hedgehog', text: "Hedgehog (Egg)"}
        {type: 'eggs', key: 'Hedgehog', text: "Hedgehog (Egg)"}
        {type: 'eggs', key: 'Hedgehog', text: "Hedgehog (Egg)"}
      ]
      gp: 30
      exp: 125


  ghost_stag:
    text: "The Spirit of Spring"
    notes: "Ahh, Spring. The time of year when color once again begins to fill the landscape. Gone are the cold, snowy mounds of winter. Where frost once stood, vibrant plant life takes its place. Luscious green leaves fill in the trees, grass returns to its former vivid hue, a rainbow of flowers rise along the plains, and a white mystical fog covers the land! ... Wait. Mystical fog? \"Oh no,\" @Inventrix says apprehensively, \"It would appear that some kind of spirit is the cause of this fog. Oh, and it is charging right at you.\""
    completion: "The spirit, seemingly unwounded, lowers its nose to the ground. A calming voice envelops your party. \"I apologize for my behavior. I have only just awoken from my slumber, and it would appear my wits have not completely returned to me. Please take these as a token of my apology.\" A cluster of eggs materialize on the grass before the spirit. Without another word, the spirit runs off into the forest with flowers falling in his wake."
    value: 4
    boss:
      name: "Ghost Stag"
      hp: 1200
      str: 2.5
    drop:
      items: [
        {type: 'eggs', key: 'Deer', text: "Deer (Egg)"}
        {type: 'eggs', key: 'Deer', text: "Deer (Egg)"}
        {type: 'eggs', key: 'Deer', text: "Deer (Egg)"}
      ]
      gp: 80
      exp: 800


  vice1:
    text: "Free Yourself of the Dragon's Influence"
    notes: "<p>They say there lies a terrible evil in the caverns of Mt. Habitica. A monster whose presence twists the wills of the strong heroes of the land, turning them towards bad habits and laziness! The beast is a grand dragon of immense power and comprised of the shadows themselves: Vice, the treacherous Shadow Wyrm. Brave Habiteers, stand up and defeat this foul beast once and for all, but only if you believe you can stand against its immense power. </p><h3>Vice Part 1: </h3><p>How can you expect to fight the beast if it already has control over you? Don't fall victim to laziness and vice! Work hard to fight against the dragon's dark influence and dispel his hold on you! </p>"
    value: 4
    lvl: 30
    boss:
      name: "Vice's Shade"
      hp: 750
      str: 1.5
    drop:
      items: [
        {type: 'quests', key: "vice2", text: "Vice Part 2 (Scroll)"}
      ]
      gp: 20
      exp: 100

  vice2:
    text: "Find the Lair of the Wyrm"
    notes: "With Vice's influence over you dispelled, you feel a surge of strength you didn't know you had return to you. Confident in yourselves and your ability to withstand the wyrm's influence, your party makes it's way to Mt. Habitica. You approach the entrance to the mountain's caverns and pause. Swells of shadows, almost like fog, wisp out from the opening. It is near impossible to see anything in front of you. The light from your lanterns seem to end abruptly where the shadows begin. It is said that only magical light can pierce the dragon's infernal haze. If you can find enough light crystals, you could make your way to the dragon."
    value: 4
    lvl: 35
    previous: 'vice1'
    collect:
      lightCrystal: text: 'Light Crystal', count: 45
    drop:
      items: [
        {type: 'quests', key: 'vice3', text: "Vice Part 3 (Scroll)"}
      ]
      gp: 20
      exp: 75

  vice3:
    text: "Vice Awakens"
    notes: "After much effort, your party has discovered Vice's lair. The hulking monster eyes your party with distaste. As shadows swirl around you, a voice whispers through your head, \"More foolish citizens of Habitica come to stop me? Cute. You'd have been wise not to come.\" The scaly titan rears back its head and prepares to attack. This is your chance! Give it everything you've got and defeat Vice once and for all!"
    completion: "The shadows dissipate from the cavern and a steely silence falls. My word, you've done it! You have defeated Vice! You and your party may finally breath a sigh of relief. Enjoy your victory, brave Habiteers, but take the lessons you've learned from battling Vice and move forward. There are still habits to be done and potentially worse evils to conquer!"
    previous: 'vice2'
    value: 4
    lvl: 40
    boss:
      name: "Vice, the Shadow Wyrm"
      hp: 1500
      str: 3
    drop:
      items: [
        {type: 'gear', key: "weapon_special_2", text: "Stephen Weber's Shaft of the Dragon"}
        {type: 'eggs', key: 'Dragon', text: "Dragon (Egg)"}
        {type: 'eggs', key: 'Dragon', text: "Dragon (Egg)"}
        {type: 'hatchingPotions', key: 'Shade', text: "Shade Hatching Potion"}
        {type: 'hatchingPotions', key: 'Shade', text: "Shade Hatching Potion"}
      ]
      gp: 100
      exp: 1000

  egg:
    text: "Egg Hunt"
    notes: "Overnight, strange plain eggs have appeared everywhere: in Matt's stables, behind the counter at the Tavern, and even among the pet eggs at the Marketplace! What a nuisance! \"Nobody knows where they came from, or what they might hatch into,\" says @Megan, \"but we can't just leave them laying around! Work hard and search hard to help me gather up these mysterious eggs. Maybe if you collect enough, there will be some extras left over for you...\""
    completion: "You did it! In gratitude, @Megan gives you ten of the eggs. \"I don't think they hatch, exactly,\" she says, \"and they certainly won't grow into mounts. But that doesn't mean you can't dye them beautiful colors!\""
    value: 1
    collect:
      plainEgg: text: 'Plain Egg', count: 100
    drop:
      items: [
        {type: 'eggs', key: 'Egg', text: "Plain Egg"}
        {type: 'eggs', key: 'Egg', text: "Plain Egg"}
        {type: 'eggs', key: 'Egg', text: "Plain Egg"}
        {type: 'eggs', key: 'Egg', text: "Plain Egg"}
        {type: 'eggs', key: 'Egg', text: "Plain Egg"}
        {type: 'eggs', key: 'Egg', text: "Plain Egg"}
        {type: 'eggs', key: 'Egg', text: "Plain Egg"}
        {type: 'eggs', key: 'Egg', text: "Plain Egg"}
        {type: 'eggs', key: 'Egg', text: "Plain Egg"}
        {type: 'eggs', key: 'Egg', text: "Plain Egg"}
      ]
      gp: 0
      exp: 0


_.each api.quests, (v,key) ->
  _.defaults v, {key,canBuy:true}

repeat = {m:true,t:true,w:true,th:true,f:true,s:true,su:true}
api.userDefaults =
  habits: [
    {type: 'habit', text: '1h Productive Work', notes: 'When you create a new Habit, you can click the Edit icon and choose for it to represent a positive habit, a negative habit, or both. For some Habits, like this one, it only makes sense to gain points.', value: 0, up: true, down: false, attribute: 'per' }
    {type: 'habit', text: 'Eat Junk Food', notes: 'For others, it only makes sense to *lose* points.', value: 0, up: false, down: true, attribute: 'con'}
    {type: 'habit', text: 'Take The Stairs', notes: 'For the rest, both + and - make sense (stairs = gain, elevator = lose).', value: 0, up: true, down: true, attribute: 'str'}
  ]

  dailys: [
    {type: 'daily', text: '1h Personal Project', notes: 'All tasks default to yellow when they are created. This means you will take only moderate damage when they are missed and will gain only a moderate reward when they are completed.', value: 0, completed: false, repeat: repeat, attribute: 'per' }
    {type: 'daily', text: 'Exercise', notes: 'Dailies you complete consistently will turn from yellow to green to blue, helping you track your progress. The higher you move up the ladder, the less damage you take for missing and less reward you receive for completing the goal.', value: 3, completed: false, repeat: repeat, attribute: 'str' }
    {type: 'daily', text: '45m Reading', notes: 'If you miss a daily frequently, it will turn darker shades of orange and red. The redder the task is, the more experience and gold it grants for success and the more damage you take for failure. This encourages you to focus on your shortcomings, the reds.', value: -10, completed: false, repeat: repeat, attribute: 'int' }
  ]

  todos: [
    {type: 'todo', text: 'Call Mom', notes: 'While not completing a to-do in a set period of time will not hurt you, they will gradually change from yellow to red, thus becoming more valuable. This will encourage you to wrap up stale To-Dos.', value: -3, completed: false, attribute: 'per' }
  ]

  rewards: [
    {type: 'reward', text: '1 Episode of Game of Thrones', notes: 'Custom rewards can come in many forms. Some people will hold off watching their favorite show unless they have the gold to pay for it.', value: 20 }
    {type: 'reward', text: 'Cake', notes: 'Other people just want to enjoy a nice piece of cake. Try to create rewards that will motivate you best.', value: 10 }
  ]

  tags: [
    {name: 'morning'}
    {name: 'afternoon'}
    {name: 'evening'}
  ]
