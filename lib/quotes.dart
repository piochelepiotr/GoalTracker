const quotes = [
  {
    "person": "Elon Musk",
    "quote":
        "Failure is an option here. If you are not failing, you are not inovating fast enough"
  },
  {
    "person": "Thomas Edison",
    "quote":
        "Genius is one percent inspiration and ninety-nine percent perspiration."
  },
  {"person": "Yogi Berra", "quote": "You can observe a lot just by watching."},
  {
    "person": "Abraham Lincoln",
    "quote": "A house divided against itself cannot stand."
  },
  {
    "person": "Johann Wolfgang von Goethe",
    "quote": "Difficulties increase the nearer we get to the goal."
  },
  {
    "person": "Byron Pulsifer",
    "quote": "Fate is in your hands and no one elses"
  },
  {"person": "Lao Tzu", "quote": "Be the chief but never the lord."},
  {
    "person": "Carl Sandburg",
    "quote": "Nothing happens unless first we dream."
  },
  {"person": "Aristotle", "quote": "Well begun is half done."},
  {
    "person": "Yogi Berra",
    "quote": "Life is a learning experience, only if you learn."
  },
  {
    "person": "Margaret Sangster",
    "quote": "Self-complacency is fatal to progress."
  },
  {
    "person": "Buddha",
    "quote": "Peace comes from within. Do not seek it without."
  },
  {"person": "Byron Pulsifer", "quote": "What you give is what you get."},
  {"person": "Iris Murdoch", "quote": "We can only learn to love by loving."},
  {
    "person": "Karen Clark",
    "quote": "Life is change. Growth is optional. Choose wisely."
  },
  {"person": "Wayne Dyer", "quote": "You'll see it when you believe it."},
  {"person": "", "quote": "Today is the tomorrow we worried about yesterday."},
  {
    "person": "",
    "quote": "It's easier to see the mistakes on someone else's paper."
  },
  {"person": "", "quote": "Every man dies. Not every man really lives."},
  {"person": "Lao Tzu", "quote": "To lead people walk behind them."},
  {
    "person": "William Shakespeare",
    "quote": "Having nothing, nothing can he lose."
  },
  {
    "person": "Henry J. Kaiser",
    "quote": "Trouble is only opportunity in work clothes."
  },
  {"person": "Publilius Syrus", "quote": "A rolling stone gathers no moss."},
  {
    "person": "Napoleon Hill",
    "quote": "Ideas are the beginning points of all fortunes."
  },
  {"person": "Donald Trump", "quote": "Everything in life is luck."},
  {
    "person": "Lao Tzu",
    "quote": "Doing nothing is better than being busy doing nothing."
  },
  {
    "person": "Benjamin Spock",
    "quote": "Trust yourself. You know more than you think you do."
  },
  {
    "person": "Confucius",
    "quote": "Study the past, if you would divine the future."
  },
  {"person": "", "quote": "The day is already blessed, find peace within it."},
  {
    "person": "Sigmund Freud",
    "quote": "From error to error one discovers the entire truth."
  },
  {
    "person": "Benjamin Franklin",
    "quote": "Well done is better than well said."
  },
  {
    "person": "Ella Williams",
    "quote": "Bite off more than you can chew, then chew it."
  },
  {
    "person": "Buddha",
    "quote": "Work out your own salvation. Do not depend on others."
  },
  {"person": "Benjamin Franklin", "quote": "One today is worth two tomorrows."},
  {
    "person": "Christopher Reeve",
    "quote": "Once you choose hope, anythings possible."
  },
  {"person": "Albert Einstein", "quote": "God always takes the simplest way."},
  {"person": "Charles Kettering", "quote": "One fails forward toward success."},
  {"person": "", "quote": "From small beginnings come great things."},
  {
    "person": "Chinese proverb",
    "quote": "Learning is a treasure that will follow its owner everywhere"
  },
  {"person": "Socrates", "quote": "Be as you wish to seem."},
  {"person": "V. Naipaul", "quote": "The world is always in movement."},
  {"person": "John Wooden", "quote": "Never mistake activity for achievement."},
  {"person": "Haddon Robinson", "quote": "What worries you masters you."},
  {"person": "Pearl Buck", "quote": "One faces the future with ones past."},
  {
    "person": "Brian Tracy",
    "quote": "Goals are the fuel in the furnace of achievement."
  },
  {"person": "Leonardo da Vinci", "quote": "Who sows virtue reaps honour."},
  {
    "person": "Dalai Lama",
    "quote": "Be kind whenever possible. It is always possible."
  },
  {"person": "Chinese proverb", "quote": "Talk doesn't cook rice."},
  {"person": "Buddha", "quote": "He is able who thinks he is able."},
  {"person": "Larry Elder", "quote": "A goal without a plan is just a wish."},
  {
    "person": "Michael Korda",
    "quote": "To succeed, we must first believe that we can."
  },
  {
    "person": "Albert Einstein",
    "quote": "Learn from yesterday, live for today, hope for tomorrow."
  },
  {
    "person": "James Lowell",
    "quote": "A weed is no more than a flower in disguise."
  },
  {"person": "Yoda", "quote": "Do, or do not. There is no try."},
  {
    "person": "Harriet Beecher Stowe",
    "quote": "All serious daring starts from within."
  },
  {
    "person": "Byron Pulsifer",
    "quote": "The best teacher is experience learned from failures."
  },
  {
    "person": "Murray Gell-Mann",
    "quote": "Think how hard physics would be if particles could think."
  },
  {
    "person": "John Lennon",
    "quote": "Love is the flower you've got to let grow."
  },
  {
    "person": "Napoleon Hill",
    "quote": "Don't wait. The time will never be just right."
  },
  {"person": "Pericles", "quote": "Time is the wisest counsellor of all."},
  {"person": "Napoleon Hill", "quote": "You give before you get."},
  {"person": "Socrates", "quote": "Wisdom begins in wonder."},
  {
    "person": "Baltasar Gracian",
    "quote": "Without courage, wisdom bears no fruit."
  },
  {"person": "Aristotle", "quote": "Change in all things is sweet."},
  {
    "person": "Byron Pulsifer",
    "quote": "What you fear is that which requires action to overcome."
  },
  {
    "person": "Cullen Hightower",
    "quote": "When performance exceeds ambition, the overlap is called success."
  },
  {
    "person": "African proverb",
    "quote": "When deeds speak, words are nothing."
  },
  {
    "person": "Wayne Dyer",
    "quote":
        "Real magic in relationships means an absence of judgement of others."
  },
  {
    "person": "Albert Einstein",
    "quote": "I never think of the future. It comes soon enough."
  },
  {"person": "Ralph Emerson", "quote": "Skill to do comes of doing."},
  {"person": "Sophocles", "quote": "Wisdom is the supreme part of happiness."},
  {
    "person": "Maya Angelou",
    "quote": "I believe that every person is born with talent."
  },
  {
    "person": "Abraham Lincoln",
    "quote": "Important principles may, and must, be inflexible."
  },
  {
    "person": "Richard Evans",
    "quote": "The undertaking of a new action brings new strength."
  },
  {
    "person": "Ralph Emerson",
    "quote": "The years teach much which the days never know."
  },
  {"person": "Ralph Emerson", "quote": "Our distrust is very expensive."},
  {"person": "Bodhidharma", "quote": "All know the way; few actually walk it."},
  {
    "person": "Johann Wolfgang von Goethe",
    "quote": "Great talent finds happiness in execution."
  },
  {
    "person": "Michelangelo",
    "quote": "Faith in oneself is the best and safest course."
  },
  {
    "person": "Winston Churchill",
    "quote":
        "Courage is going from failure to failure without losing enthusiasm."
  },
  {
    "person": "Leo Tolstoy",
    "quote": "The two most powerful warriors are patience and time."
  },
  {
    "person": "Lao Tzu",
    "quote": "Anticipate the difficult by managing the easy."
  },
  {
    "person": "Buddha",
    "quote": "Those who are free of resentful thoughts surely find peace."
  },
  {
    "person": "Sophocles",
    "quote": "A short saying often contains much wisdom."
  },
  {"person": "", "quote": "It takes both sunshine and rain to make a rainbow."},
  {"person": "", "quote": "A beautiful thing is never perfect."},
  {"person": "Princess Diana", "quote": "Only do what your heart tells you."},
  {
    "person": "John Pierrakos",
    "quote": "Life is movement-we breathe, we eat, we walk, we move!"
  },
  {
    "person": "Eleanor Roosevelt",
    "quote": "No one can make you feel inferior without your consent."
  },
  {
    "person": "Richard Bach",
    "quote": "Argue for your limitations, and sure enough theyre yours."
  },
  {
    "person": "Seneca",
    "quote": "Luck is what happens when preparation meets opportunity."
  },
  {
    "person": "Napoleon Bonaparte",
    "quote": "Victory belongs to the most persevering."
  },
  {
    "person": "William Shakespeare",
    "quote": "Love all, trust a few, do wrong to none."
  },
  {
    "person": "Richard Bach",
    "quote": "In order to win, you must expect to win."
  },
  {"person": "Napoleon Hill", "quote": "A goal is a dream with a deadline."},
  {"person": "Napoleon Hill", "quote": "You can do it if you believe you can!"},
  {
    "person": "Bo Jackson",
    "quote": "Set your goals high, and don't stop till you get there."
  },
  {
    "person": "",
    "quote": "Every new day is another chance to change your life."
  },
  {"person": "Thich Nhat Hanh", "quote": "Smile, breathe, and go slowly."},
  {
    "person": "Liberace",
    "quote": "Nobody will believe in you unless you believe in yourself."
  },
  {"person": "William Arthur Ward", "quote": "Do more than dream: work."},
  {"person": "Seneca", "quote": "No man was ever wise by chance."},
  {"person": "", "quote": "Some pursue happiness, others create it."},
  {
    "person": "William Shakespeare",
    "quote": "He that is giddy thinks the world turns round."
  },
  {
    "person": "Ellen Gilchrist",
    "quote": "Don't ruin the present with the ruined past."
  },
  {
    "person": "Albert Schweitzer",
    "quote": "Do something wonderful, people may imitate it."
  },
  {"person": "", "quote": "We do what we do because we believe."},
  {
    "person": "Eleanor Roosevelt",
    "quote": "Do one thing every day that scares you."
  },
  {
    "person": "Byron Pulsifer",
    "quote": "If you cannot be silent be brilliant and thoughtful."
  },
  {
    "person": "Carl Jung",
    "quote": "Who looks outside, dreams; who looks inside, awakes."
  },
  {"person": "Buddha", "quote": "What we think, we become."},
  {"person": "Lord Herbert", "quote": "The shortest answer is doing."},
  {
    "person": "Leonardo da Vinci",
    "quote": "All our knowledge has its origins in our perceptions."
  },
  {"person": "", "quote": "The harder you fall, the higher you bounce."},
  {
    "person": "Anne Wilson Schaef",
    "quote": "Trusting our intuition often saves us from disaster."
  },
  {"person": "Sojourner Truth", "quote": "Truth is powerful and it prevails."},
  {"person": "Elizabeth Browning", "quote": "Light tomorrow with today!"},
  {"person": "German proverb", "quote": "Silence is a fence around wisdom."},
  {
    "person": "Madame de Stael",
    "quote": "Society develops wit, but its contemplation alone forms genius."
  },
  {
    "person": "Richard Bach",
    "quote": "The simplest things are often the truest."
  },
  {"person": "", "quote": "Everyone smiles in the same language."},
  {
    "person": "Bernadette Devlin",
    "quote": "Yesterday I dared to struggle. Today I dare to win."
  },
  {
    "person": "Napoleon Hill",
    "quote": "No alibi will save you from accepting the responsibility."
  },
  {"person": "Walt Disney", "quote": "If you can dream it, you can do it."},
  {"person": "Buddha", "quote": "It is better to travel well than to arrive."},
  {
    "person": "Anais Nin",
    "quote": "Life shrinks or expands in proportion to one's courage."
  },
  {"person": "Sun Tzu", "quote": "You have to believe in yourself."},
  {"person": "Wayne Dyer", "quote": "Our intention creates our reality."},
  {
    "person": "Confucius",
    "quote": "Silence is a true friend who never betrays."
  },
  {
    "person": "Johann Wolfgang von Goethe",
    "quote": "Character develops itself in the stream of life."
  },
  {
    "person": "American proverb",
    "quote": "From little acorns mighty oaks do grow."
  },
  {
    "person": "Jon Kabat-Zinn",
    "quote": "You can't stop the waves, but you can learn to surf."
  },
  {
    "person": "Gustave Flaubert",
    "quote": "Reality does not conform to the ideal, but confirms it."
  },
  {"person": "William Shakespeare", "quote": "Speak low, if you speak love."},
  {
    "person": "Johann Wolfgang von Goethe",
    "quote": "A really great talent finds its happiness in execution."
  },
  {
    "person": "John Lennon",
    "quote": "Reality leaves a lot to the imagination."
  },
  {"person": "Seneca", "quote": "The greatest remedy for anger is delay."},
  {
    "person": "Pearl Buck",
    "quote": "Growth itself contains the germ of happiness."
  },
  {
    "person": "",
    "quote": "You can do what's reasonable or you can decide what's possible."
  },
  {
    "person": "Leonardo da Vinci",
    "quote": "Nothing strengthens authority so much as silence."
  },
  {"person": "Confucius", "quote": "Wherever you go, go with all your heart."},
  {
    "person": "Albert Einstein",
    "quote": "The only real valuable thing is intuition."
  },
  {
    "person": "Ralph Emerson",
    "quote": "Good luck is another name for tenacity of purpose."
  },
  {"person": "Sylvia Voirol", "quote": "Rainbows apologize for angry skies."},
  {
    "person": "",
    "quote": "Friendship isn't a big thing. It's a million little things."
  },
  {
    "person": "Theophrastus",
    "quote": "Time is the most valuable thing a man can spend."
  },
  {"person": "Tony Robbins", "quote": "Whatever happens, take responsibility."},
  {
    "person": "Oscar Wilde",
    "quote": "Experience is simply the name we give our mistakes."
  },
  {"person": "Wayne Dyer", "quote": "I think and that is all that I am."},
  {
    "person": "",
    "quote": "A good plan today is better than a perfect plan tomorrow."
  },
  {
    "person": "Gloria Steinem",
    "quote": "If the shoe doesn't fit, must we change the foot?"
  },
  {"person": "Marcus Aurelius", "quote": "Each day provides its own gifts."},
  {
    "person": "Publilius Syrus",
    "quote": "While we stop to think, we often miss our opportunity."
  },
  {
    "person": "Bernard Shaw",
    "quote":
        "Life isn't about finding yourself. Life is about creating yourself."
  },
  {
    "person": "Richard Bach",
    "quote":
        "To bring anything into your life, imagine that it's already there."
  },
  {
    "person": "German proverb",
    "quote": "Begin to weave and God will give you the thread."
  },
  {
    "person": "Confucius",
    "quote": "The more you know yourself, the more you forgive yourself."
  },
  {
    "person": "",
    "quote":
        "Someone remembers, someone cares; your name is whispered in someone's prayers."
  },
  {
    "person": "Mary Bethune",
    "quote":
        "Without faith, nothing is possible. With it, nothing is impossible."
  },
  {
    "person": "Albert Einstein",
    "quote": "Once we accept our limits, we go beyond them."
  },
  {
    "person": "",
    "quote": "Don't be pushed by your problems; be led by your dreams."
  },
  {
    "person": "Brian Tracy",
    "quote":
        "Whatever we expect with confidence becomes our own self-fulfilling prophecy."
  },
  {"person": "Pablo Picasso", "quote": "Everything you can imagine is real."},
  {
    "person": "Usman Asif",
    "quote": "Fear is a darkroom where negatives develop."
  },
  {
    "person": "Napoleon Bonaparte",
    "quote": "The truest wisdom is a resolute determination."
  },
  {
    "person": "Victor Hugo",
    "quote": "Life is the flower for which love is the honey."
  },
  {"person": "Epictetus", "quote": "Freedom is the right to live as we wish."},
  {"person": "", "quote": "Change your thoughts, change your life!"},
  {
    "person": "Robert Heller",
    "quote": "Never ignore a gut feeling, but never believe that it's enough."
  },
  {
    "person": "Marcus Aurelius",
    "quote": "Loss is nothing else but change,and change is Natures delight."
  },
  {
    "person": "Byron Pulsifer",
    "quote": "Someone is special only if you tell them."
  },
  {"person": "", "quote": "Today is the tomorrow you worried about yesterday."},
  {
    "person": "Thich Nhat Hanh",
    "quote": "There is no way to happiness, happiness is the way."
  },
  {"person": "", "quote": "The day always looks brighter from behind a smile."},
  {"person": "", "quote": "A stumble may prevent a fall."},
  {"person": "Lao Tzu", "quote": "He who talks more is sooner exhausted."},
  {"person": "Lao Tzu", "quote": "He who is contented is rich."},
  {
    "person": "Plutarch",
    "quote": "What we achieve inwardly will change outer reality."
  },
  {
    "person": "Ralph Waldo Emerson",
    "quote": "Our strength grows out of our weaknesses."
  },
  {
    "person": "Mahatma Gandhi",
    "quote": "We must become the change we want to see."
  },
  {
    "person": "Napoleon Hill",
    "quote": "Happiness is found in doing, not merely possessing."
  },
  {"person": "", "quote": "Put your future in good hands : your own."},
  {
    "person": "Wit",
    "quote": "We choose our destiny in the way we treat others."
  },
  {
    "person": "Voltaire",
    "quote": "No snowflake in an avalanche ever feels responsible."
  },
  {"person": "Virgil", "quote": "Fortune favours the brave."},
  {"person": "Robert Frost", "quote": "The best way out is always through."},
  {
    "person": "Seneca",
    "quote": "The mind unlearns with difficulty what it has long learned."
  },
  {
    "person": "Abraham Lincoln",
    "quote": "I destroy my enemies when I make them my friends."
  },
  {"person": "Thomas Fuller", "quote": "No garden is without its weeds."},
  {
    "person": "Elbert Hubbard",
    "quote": "There is no failure except in no longer trying."
  },
  {
    "person": "Turkish proverb",
    "quote": "Kind words will unlock an iron door."
  },
  {
    "person": "Hugh Miller",
    "quote": "Problems are only opportunities with thorns on them."
  },
  {
    "person": "A. Powell Davies",
    "quote": "Life is just a chance to grow a soul."
  },
  {
    "person": "Johann Wolfgang von Goethe",
    "quote": "Mountains cannot be surmounted except by winding paths."
  },
  {
    "person": "Thich Nhat Hanh",
    "quote":
        "May our hearts garden of awakening bloom with hundreds of flowers."
  },
  {"person": "John Dryden", "quote": "Fortune befriends the bold."},
  {
    "person": "Friedrich von Schiller",
    "quote": "Keep true to the dreams of thy youth."
  },
  {
    "person": "Mike Ditka",
    "quote": "You're never a loser until you quit trying."
  },
  {
    "person": "Immanuel Kant",
    "quote": "Science is organized knowledge. Wisdom is organized life."
  },
  {
    "person": "Johann Wolfgang von Goethe",
    "quote": "Knowing is not enough; we must apply!"
  },
  {
    "person": "Richard Bach",
    "quote": "Strong beliefs win strong men, and then make them stronger."
  },
  {
    "person": "Albert Camus",
    "quote": "Autumn is a second spring when every leaf is a flower."
  },
  {
    "person": "Toni Morrison",
    "quote": "If you surrender to the wind, you can ride it."
  },
  {
    "person": "Helen Keller",
    "quote": "Keep yourself to the sunshine and you cannot see the shadow."
  },
  {
    "person": "Paulo Coelho",
    "quote": "Write your plans in pencil and give God the eraser."
  },
  {
    "person": "Pablo Picasso",
    "quote": "Inspiration exists, but it has to find us working."
  },
  {
    "person": "Jonathan Kozol",
    "quote": "Pick battles big enough to matter, small enough to win."
  },
  {
    "person": "Janis Joplin",
    "quote": "Don't compromise yourself. You are all you've got."
  },
  {"person": "Sophocles", "quote": "A short saying oft contains much wisdom."},
  {
    "person": "Epictetus",
    "quote": "Difficulties are things that show a person what they are."
  },
  {
    "person": "Honore de Balzac",
    "quote": "When you doubt your power, you give power to your doubt."
  },
  {
    "person": "Ovid",
    "quote": "The cause is hidden. The effect is visible to all."
  },
  {
    "person": "Francis Bacon",
    "quote": "A prudent question is one half of wisdom."
  },
  {
    "person": "Tony Robbins",
    "quote": "The path to success is to take massive, determined action."
  },
  {"person": "Manuel Puig", "quote": "I allow my intuition to lead my path."},
  {
    "person": "William R. Inge",
    "quote": "Nature takes away any faculty that is not used."
  },
  {"person": "Epictetus", "quote": "If you wish to be a writer, write."},
  {
    "person": "Wayne Dyer",
    "quote": "There is no way to prosperity, prosperity is the way."
  },
  {
    "person": "Jim Rohn",
    "quote": "Either you run the day or the day runs you."
  },
  {
    "person": "Publilius Syrus",
    "quote": "Better be ignorant of a matter than half know it."
  },
  {
    "person": "Oprah Winfrey",
    "quote":
        "Follow your instincts. That is where true wisdom manifests itself."
  },
  {
    "person": "Benjamin Franklin",
    "quote": "There never was a good knife made of bad steel."
  },
  {
    "person": "Anatole France",
    "quote": "To accomplish great things, we must dream as well as act."
  },
  {
    "person": "Saint Augustine",
    "quote": "Patience is the companion of wisdom."
  },
  {
    "person": "Buddha",
    "quote": "The mind is everything. What you think you become."
  },
  {
    "person": "Voltaire",
    "quote": "To enjoy life, we must touch much of it lightly."
  },
  {"person": "Maya Lin", "quote": "To fly, we have to have resistance."},
  {"person": "", "quote": "What you see depends on what you're looking for."},
  {
    "person": "Blaise Pascal",
    "quote": "The heart has its reasons which reason knows not of."
  },
  {
    "person": "William Shakespeare",
    "quote": "Be great in act, as you have been in thought."
  },
  {"person": "Napoleon Bonaparte", "quote": "Imagination rules the world."},
  {
    "person": "Blaise Pascal",
    "quote": "Kind words do not cost much. Yet they accomplish much."
  },
  {
    "person": "Michelangelo",
    "quote": "There is no greater harm than that of time wasted."
  },
  {
    "person": "Jonas Salk",
    "quote": "Intuition will tell the thinking mind where to look next."
  },
  {"person": "", "quote": "Worry gives a small thing a big shadow."},
  {
    "person": "Napoleon Hill",
    "quote": "Fears are nothing more than a state of mind."
  },
  {
    "person": "Lao Tzu",
    "quote": "The journey of a thousand miles begins with one step."
  },
  {
    "person": "Peter Drucker",
    "quote":
        "Efficiency is doing things right; effectiveness is doing the right things."
  },
  {
    "person": "Luisa Sigea",
    "quote": "Blaze with the fire that is never extinguished."
  },
  {
    "person": "Dr. Seuss",
    "quote": "Don't cry because it's over. Smile because it happened."
  },
  {
    "person": "Jason Fried",
    "quote": "No is easier to do. Yes is easier to say."
  },
  {
    "person": "Confucius",
    "quote": "To be wrong is nothing unless you continue to remember it."
  },
  {
    "person": "Babe Ruth",
    "quote": "Yesterdays home runs don't win today's games."
  },
  {
    "person": "Carlyle",
    "quote": "Silence is deep as Eternity, Speech is shallow as Time."
  },
  {
    "person": "Leo F. Buscaglia",
    "quote": "Don't smother each other. No one can grow in the shade."
  },
  {
    "person": "Lao Tzu",
    "quote": "An ant on the move does more than a dozing ox"
  },
  {
    "person": "Indira Gandhi",
    "quote": "You can't shake hands with a clenched fist."
  },
  {
    "person": "Plato",
    "quote": "A good decision is based on knowledge and not on numbers."
  },
  {"person": "Confucius", "quote": "The cautious seldom err."},
  {
    "person": "Frederick Douglass",
    "quote": "If there is no struggle, there is no progress."
  },
  {
    "person": "Willa Cather",
    "quote": "Where there is great love, there are always miracles."
  },
  {"person": "John Lennon", "quote": "Time you enjoy wasting, was not wasted."},
  {
    "person": "Richard Bach",
    "quote": "Every problem has a gift for you in its hands."
  },
  {
    "person": "Jean de la Fontaine",
    "quote": "Sadness flies away on the wings of time."
  },
  {
    "person": "Publilius Syrus",
    "quote": "I have often regretted my speech, never my silence."
  },
  {
    "person": "Thomas Jefferson",
    "quote": "Never put off till tomorrow what you can do today."
  },
  {
    "person": "Thomas Dewar",
    "quote": "Minds are like parachutes. They only function when open."
  },
  {
    "person": "George Patton",
    "quote": "If a man does his best, what else is there?"
  },
  {
    "person": "Benjamin Disraeli",
    "quote": "The secret of success is constancy to purpose."
  },
  {
    "person": "Ralph Emerson",
    "quote": "Life is a progress, and not a station."
  },
  {
    "person": "Horace Friess",
    "quote":
        "All seasons are beautiful for the person who carries happiness within."
  },
  {
    "person": "Elbert Hubbard",
    "quote": "To avoid criticism, do nothing, say nothing, be nothing."
  },
  {"person": "Ovid", "quote": "All things change; nothing perishes."},
  {"person": "Haynes Bayly", "quote": "Absence makes the heart grow fonder."},
  {
    "person": "Lauren Bacall",
    "quote": "Imagination is the highest kite one can fly."
  },
  {
    "person": "Frank Herbert",
    "quote":
        "The beginning of knowledge is the discovery of something we do not understand."
  },
  {
    "person": "Elizabeth Browning",
    "quote":
        "Love doesn't make the world go round, love is what makes the ride worthwhile."
  },
  {
    "person": "Dalai Lama",
    "quote":
        "I believe that we are fundamentally the same and have the same basic potential."
  },
  {
    "person": "Edward Gibbon",
    "quote":
        "The winds and waves are always on the side of the ablest navigators."
  },
  {
    "person": "Eleanor Roosevelt",
    "quote":
        "The future belongs to those who believe in the beauty of their dreams."
  },
  {
    "person": "",
    "quote":
        "To get something you never had, you have to do something you never did."
  },
  {
    "person": "",
    "quote":
        "Be thankful when you don't know something for it gives you the opportunity to learn."
  },
  {
    "person": "Mahatma Gandhi",
    "quote":
        "Strength does not come from physical capacity. It comes from an indomitable will."
  },
  {
    "person": "Og Mandino",
    "quote":
        "Each misfortune you encounter will carry in it the seed of tomorrows good luck."
  },
  {
    "person": "Lewis B. Smedes",
    "quote":
        "To forgive is to set a prisoner free and realize that prisoner was you."
  },
  {
    "person": "Buddha",
    "quote":
        "In separateness lies the world's great misery, in compassion lies the world's true strength."
  },
  {
    "person": "Nikos Kazantzakis",
    "quote":
        "By believing passionately in something that does not yet exist, we create it."
  },
  {
    "person": "",
    "quote":
        "Letting go isn't the end of the world; it's the beginning of a new life."
  },
  {
    "person": "John Eliot",
    "quote":
        "All the great performers I have worked with are fuelled by a personal dream."
  },
  {
    "person": "Marie Curie",
    "quote":
        "I never see what has been done; I only see what remains to be done."
  },
  {
    "person": "Seneca",
    "quote":
        "Begin at once to live and count each separate day as a separate life."
  },
  {
    "person": "Lawrence Peter",
    "quote":
        "If you don't know where you are going, you will probably end up somewhere else."
  },
  {
    "person": "Hannah More",
    "quote":
        "It is not so important to know everything as to appreciate what we learn."
  },
  {
    "person": "John Berry",
    "quote":
        "The bird of paradise alights only upon the hand that does not grasp."
  },
  {
    "person": "William Yeats",
    "quote":
        "Think as a wise man but communicate in the language of the people."
  },
  {
    "person": "Epictetus",
    "quote":
        "Practice yourself, for heavens sake in little things, and then proceed to greater."
  },
  {
    "person": "Seneca",
    "quote":
        "If one does not know to which port is sailing, no wind is favorable."
  },
  {
    "person": "",
    "quote":
        "Our greatest glory is not in never failing but rising everytime we fall."
  },
  {
    "person": "",
    "quote":
        "Being right is highly overrated. Even a stopped clock is right twice a day."
  },
  {
    "person": "Ken S. Keyes",
    "quote":
        "To be upset over what you don't have is to waste what you do have."
  },
  {
    "person": "Thomas Edison",
    "quote":
        "If we did the things we are capable of, we would astound ourselves."
  },
  {
    "person": "Marie Curie",
    "quote": "Nothing in life is to be feared. It is only to be understood."
  },
  {
    "person": "Tony Robbins",
    "quote":
        "Successful people ask better questions, and as a result, they get better answers."
  },
  {
    "person": "",
    "quote":
        "Love is not blind; it simply enables one to see things others fail to see."
  },
  {
    "person": "Anne Schaef",
    "quote": "Life is a process. We are a process. The universe is a process."
  },
  {
    "person": "Eleanor Roosevelt",
    "quote":
        "I think somehow we learn who we really are and then live with that decision."
  },
  {
    "person": "Kenneth Patton",
    "quote": "We learn what we have said from those who listen to our speaking."
  },
  {
    "person": "",
    "quote":
        "If you get up one more time than you fall, you will make it through."
  },
  {
    "person": "Flora Whittemore",
    "quote": "The doors we open and close each day decide the lives we live."
  },
  {
    "person": "H. W. Arnold",
    "quote":
        "The worst bankrupt in the world is the person who has lost his enthusiasm."
  },
  {
    "person": "Buddha",
    "quote":
        "Happiness comes when your work and words are of benefit to yourself and others."
  },
  {
    "person": "",
    "quote":
        "Don't focus on making the right decision, focus on making the decision the right one."
  },
  {
    "person": "Wayne Dyer",
    "quote":
        "Everything is perfect in the universe, even your desire to improve it."
  },
  {
    "person": "Buddha",
    "quote":
        "Just as a candle cannot burn without fire, men cannot live without a spiritual life."
  },
  {
    "person": "Mark Twain",
    "quote":
        "A thing long expected takes the form of the unexpected when at last it comes."
  },
  {
    "person": "Benjamin Disraeli",
    "quote":
        "Action may not always bring happiness; but there is no happiness without action."
  },
  {
    "person": "Oprah Winfrey",
    "quote":
        "I don't believe in failure. It is not failure if you enjoyed the process."
  },
  {
    "person": "Confucius",
    "quote": "What you do not want done to yourself, do not do to others."
  },
  {
    "person": "Winston Churchill",
    "quote":
        "Short words are best and the old words when short are best of all."
  },
  {
    "person": "Buddha",
    "quote":
        "If you light a lamp for somebody, it will also brighten your path."
  },
  {
    "person": "Lin-yutang",
    "quote":
        "I have done my best: that is about all the philosophy of living one needs."
  },
  {
    "person": "Byron Pulsifer",
    "quote":
        "Give thanks for the rain of life that propels us to reach new horizons."
  },
  {
    "person": "",
    "quote":
        "Love is just a word until someone comes along and gives it meaning."
  },
  {
    "person": "",
    "quote":
        "We all have problems. The way we solve them is what makes us different."
  },
  {
    "person": "Dave Weinbaum",
    "quote":
        "The secret to a rich life is to have more beginnings than endings."
  },
  {
    "person": "Ralph Waldo Emerson",
    "quote":
        "It is only when the mind and character slumber that the dress can be seen."
  },
  {
    "person": "Maya Angelou",
    "quote":
        "If you don't like something, change it. If you can't change it, change your attitude."
  },
  {
    "person": "Confucius",
    "quote":
        "Reviewing what you have learned and learning anew, you are fit to be a teacher."
  },
  {
    "person": "Augustinus Sanctus",
    "quote":
        "The world is a book, and those who do not travel read only a page."
  },
  {
    "person": "Henri-Frederic Amiel",
    "quote":
        "So long as a person is capable of self-renewal they are a living being."
  },
  {
    "person": "Louisa Alcott",
    "quote": "I'm not afraid of storms, for Im learning how to sail my ship."
  },
  {
    "person": "Voltaire",
    "quote":
        "Think for yourselves and let others enjoy the privilege to do so too."
  },
  {
    "person": "Annie Dillard",
    "quote": "How we spend our days is, of course, how we spend our lives."
  },
  {
    "person": "Man Ray",
    "quote":
        "It has never been my object to record my dreams, just to realize them."
  },
  {
    "person": "Wayne Dyer",
    "quote":
        "Be miserable. Or motivate yourself. Whatever has to be done, it's always your choice."
  },
  {
    "person": "Henry Ford",
    "quote":
        "If you think you can, you can. And if you think you can't, you're right."
  },
  {
    "person": "St. Augustine",
    "quote": "Better to have loved and lost, than to have never loved at all."
  },
  {
    "person": "Leo Tolstoy",
    "quote":
        "Everyone thinks of changing the world, but no one thinks of changing himself."
  },
  {
    "person": "Richard Bach",
    "quote": "The best way to pay for a lovely moment is to enjoy it."
  },
  {
    "person": "John De Paola",
    "quote":
        "Slow down and everything you are chasing will come around and catch you."
  },
  {
    "person": "Buddha",
    "quote":
        "Your worst enemy cannot harm you as much as your own unguarded thoughts."
  },
  {
    "person": "Lily Tomlin",
    "quote":
        "I always wanted to be somebody, but I should have been more specific."
  },
  {
    "person": "John Lennon",
    "quote": "Yeah we all shine on, like the moon, and the stars, and the sun."
  },
  {
    "person": "Martin Fischer",
    "quote":
        "Knowledge is a process of piling up facts; wisdom lies in their simplification."
  },
  {
    "person": "Albert Einstein",
    "quote":
        "Life is like riding a bicycle. To keep your balance you must keep moving."
  },
  {
    "person": "Albert Schweitzer",
    "quote":
        "We should all be thankful for those people who rekindle the inner spirit."
  },
  {
    "person": "Thomas Edison",
    "quote":
        "Opportunity is missed by most because it is dressed in overalls and looks like work."
  },
  {
    "person": "Lao Tzu",
    "quote":
        "If you correct your mind, the rest of your life will fall into place."
  },
  {
    "person": "Ralph Emerson",
    "quote": "The world makes way for the man who knows where he is going."
  },
  {
    "person": "Henry David Thoreau",
    "quote": "I cannot make my days longer so I strive to make them better."
  },
  {
    "person": "Chinese proverb",
    "quote":
        "Tension is who you think you should be. Relaxation is who you are."
  },
  {
    "person": "Helen Keller",
    "quote":
        "Never bend your head. Always hold it high. Look the world right in the eye."
  },
  {
    "person": "Calvin Coolidge",
    "quote": "We cannot do everything at once, but we can do something at once."
  },
  {
    "person": "Abraham Lincoln",
    "quote":
        "You have to do your own growing no matter how tall your grandfather was."
  },
  {
    "person": "",
    "quote":
        "Invent your world. Surround yourself with people, color, sounds, and work that nourish you."
  },
  {
    "person": "General Douglas MacArthur",
    "quote": "It is fatal to enter any war without the will to win it."
  },
  {
    "person": "Julius Charles Hare",
    "quote":
        "Be what you are. This is the first step toward becoming better than you are."
  },
  {
    "person": "Buckminster Fuller",
    "quote":
        "There is nothing in a caterpillar that tells you it's going to be a butterfly."
  },
  {
    "person": "Dalai Lama",
    "quote":
        "Love and compassion open our own inner life, reducing stress, distrust and loneliness."
  },
  {
    "person": "Confucius",
    "quote":
        "The superior man is satisfied and composed; the mean man is always full of distress."
  },
  {
    "person": "Bruce Lee",
    "quote":
        "If you spend too much time thinking about a thing, you'll never get it done."
  },
  {
    "person": "Buddha",
    "quote": "The way is not in the sky. The way is in the heart."
  },
  {
    "person": "Abraham Lincoln",
    "quote": "Most people are about as happy as they make up their minds to be"
  },
  {
    "person": "Buddha",
    "quote":
        "Three things cannot be long hidden: the sun, the moon, and the truth."
  },
  {
    "person": "Dalai Lama",
    "quote":
        "More often than not, anger is actually an indication of weakness rather than of strength."
  },
  {
    "person": "Jim Beggs",
    "quote":
        "Before you put on a frown, make absolutely sure there are no smiles available."
  },
  {
    "person": "Donald Kircher",
    "quote":
        "A man of ability and the desire to accomplish something can do anything."
  },
  {
    "person": "Buddha",
    "quote":
        "You, yourself, as much as anybody in the entire universe, deserve your love and affection."
  },
  {
    "person": "Eckhart Tolle",
    "quote":
        "It is not uncommon for people to spend their whole life waiting to start living."
  },
  {
    "person": "H. Jackson Browne",
    "quote": "Don't be afraid to go out on a limb. That's where the fruit is."
  },
  {
    "person": "Marquis Vauvenargues",
    "quote":
        "Wicked people are always surprised to find ability in those that are good."
  },
  {
    "person": "Wayne Dyer",
    "quote":
        "If you change the way you look at things, the things you look at change."
  },
  {
    "person": "Napoleon Hill",
    "quote": "No man can succeed in a line of endeavor which he does not like."
  },
  {
    "person": "Buddha",
    "quote":
        "You will not be punished for your anger, you will be punished by your anger."
  },
  {
    "person": "Robert Stevenson",
    "quote":
        "Don't judge each day by the harvest you reap but by the seeds you plant."
  },
  {
    "person": "Andy Warhol",
    "quote":
        "They say that time changes things, but you actually have to change them yourself."
  },
  {
    "person": "Benjamin Disraeli",
    "quote":
        "Never apologize for showing feelings. When you do so, you apologize for the truth."
  },
  {
    "person": "Pema Chodron",
    "quote":
        "The truth you believe and cling to makes you unavailable to hear anything new."
  },
  {
    "person": "Morris West",
    "quote":
        "If you spend your whole life waiting for the storm, you'll never enjoy the sunshine."
  },
  {
    "person": "Franklin Roosevelt",
    "quote":
        "The only limit to our realization of tomorrow will be our doubts of today."
  },
  {
    "person": "Edwin Chapin",
    "quote":
        "Every action of our lives touches on some chord that will vibrate in eternity."
  },
  {
    "person": "Les Brown",
    "quote":
        "Shoot for the moon. Even if you miss, you'll land among the stars."
  },
  {
    "person": "Confucius",
    "quote": "It does not matter how slowly you go as long as you do not stop."
  },
  {
    "person": "",
    "quote":
        "Every day may not be good, but there's something good in every day."
  },
  {
    "person": "Abraham Lincoln",
    "quote": "Most folks are about as happy as they make up their minds to be."
  },
  {
    "person": "Lao Tzu",
    "quote":
        "If you would take, you must first give, this is the beginning of intelligence."
  },
  {
    "person": "",
    "quote":
        "Some people think it's holding that makes one strong, sometimes it's letting go."
  },
  {
    "person": "Havelock Ellis",
    "quote":
        "It is on our failures that we base a new and different and better success."
  },
  {
    "person": "John Ruskin",
    "quote":
        "Quality is never an accident; it is always the result of intelligent effort."
  },
  {
    "person": "Confucius",
    "quote":
        "To study and not think is a waste. To think and not study is dangerous."
  },
  {
    "person": "Ralph Emerson",
    "quote":
        "Life is a succession of lessons, which must be lived to be understood."
  },
  {
    "person": "Thomas Hardy",
    "quote":
        "Time changes everything except something within us which is always surprised by change."
  },
  {
    "person": "Wayne Dyer",
    "quote":
        "You are important enough to ask and you are blessed enough to receive back."
  },
  {
    "person": "Napoleon Hill",
    "quote": "If you cannot do great things, do small things in a great way."
  },
  {
    "person": "Oprah Winfrey",
    "quote":
        "If you want your life to be more rewarding, you have to change the way you think."
  },
  {
    "person": "Leon Blum",
    "quote":
        "The free man is he who does not fear to go to the end of his thought."
  },
  {
    "person": "Henry Moore",
    "quote":
        "There is no retirement for an artist, it's your way of living so there is no end to it."
  },
  {
    "person": "Epictetus",
    "quote":
        "Make the best use of what is in your power, and take the rest as it happens."
  },
  {
    "person": "Louise Hay",
    "quote":
        "The thoughts we choose to think are the tools we use to paint the canvas of our lives."
  },
  {
    "person": "Thomas Jefferson",
    "quote":
        "I'm a great believer in luck and I find the harder I work, the more I have of it."
  },
  {
    "person": "Christopher Morley",
    "quote":
        "There is only one success, to be able to spend your life in your own way."
  },
  {
    "person": "Confucius",
    "quote":
        "Choose a job you love, and you will never have to work a day in your life."
  },
  {
    "person": "Desiderius Erasmus",
    "quote":
        "The fox has many tricks. The hedgehog has but one. But that is the best of all."
  },
  {
    "person": "",
    "quote":
        "As the rest of the world is walking out the door, your best friends are the ones walking in."
  },
  {
    "person": "Tom Lehrer",
    "quote":
        "Life is like a sewer. What you get out of it depends on what you put into it."
  },
  {
    "person": "Ben Stein",
    "quote":
        "The first step to getting the things you want out of life is this: decide what you want."
  },
  {
    "person": "",
    "quote":
        "A good teacher is like a candle, it consumes itself to light the way for others."
  },
  {
    "person": "",
    "quote":
        "Life is not measured by the breaths we take, but by the moments that take our breath."
  },
  {
    "person": "Aristotle",
    "quote":
        "It is the mark of an educated mind to be able to entertain a thought without accepting it."
  },
  {
    "person": "James Barrie",
    "quote":
        "We never understand how little we need in this world until we know the loss of it."
  },
  {
    "person": "",
    "quote":
        "The real measure of your wealth is how much youd be worth if you lost all your money."
  },
  {
    "person": "Bruce Lee",
    "quote":
        "Take no thought of who is right or wrong or who is better than. Be not for or against."
  },
  {
    "person": "Niels Bohr",
    "quote":
        "How wonderful that we have met with a paradox. Now we have some hope of making progress."
  },
  {
    "person": "Byron Pulsifer",
    "quote":
        "Sadness may be part of life but there is no need to let it dominate your entire life."
  },
  {
    "person": "Epictetus",
    "quote":
        "Nature gave us one tongue and two ears so we could hear twice as much as we speak."
  },
  {
    "person": "Bruce Lee",
    "quote":
        "Take things as they are. Punch when you have to punch. Kick when you have to kick."
  },
  {
    "person": "Paavo Nurmi",
    "quote":
        "Mind is everything: muscle, pieces of rubber. All that I am, I am because of my mind."
  },
  {
    "person": "Ralph Emerson",
    "quote":
        "It is one of the blessings of old friends that you can afford to be stupid with them."
  },
  {
    "person": "E. M. Forster",
    "quote":
        "One must be fond of people and trust them if one is not to make a mess of life."
  },
  {
    "person": "Lucille Ball",
    "quote":
        "Id rather regret the things that I have done than the things that I have not done."
  },
  {
    "person": "John Muir",
    "quote":
        "When one tugs at a single thing in nature, he finds it attached to the rest of the world."
  },
  {
    "person": "Buddha",
    "quote":
        "To live a pure unselfish life, one must count nothing as ones own in the midst of abundance."
  },
  {
    "person": "Confucius",
    "quote":
        "I am not bothered by the fact that I am unknown. I am bothered when I do not know others."
  },
  {
    "person": "Pablo Picasso",
    "quote":
        "I am always doing that which I cannot do, in order that I may learn how to do it."
  },
  {
    "person": "Danielle Ingrum",
    "quote":
        "Give it all you've got because you never know if there's going to be a next time."
  },
  {
    "person": "Socrates",
    "quote":
        "The greatest way to live with honor in this world is to be what we pretend to be."
  },
  {
    "person": "Ovid",
    "quote":
        "Let your hook always be cast; in the pool where you least expect it, there will be a fish."
  },
  {
    "person": "Alan Watts",
    "quote":
        "No valid plans for the future can be made by those who have no capacity for living now."
  },
  {
    "person": "",
    "quote":
        "If we are facing in the right direction, all we have to do is keep on walking."
  },
  {
    "person": "Helen Keller",
    "quote":
        "We could never learn to be brave and patient if there were only joy in the world."
  },
  {
    "person": "Marcus Aurelius",
    "quote": "If it is not right do not do it; if it is not true do not say it."
  },
  {
    "person": "Harry Kemp",
    "quote":
        "The poor man is not he who is without a cent, but he who is without a dream."
  },
  {
    "person": "",
    "quote":
        "Peace of mind is not the absence of conflict from life, but the ability to cope with it."
  },
  {
    "person": "Albert Einstein",
    "quote":
        "Try not to become a man of success, but rather try to become a man of value."
  },
  {
    "person": "Rene Descartes",
    "quote":
        "It is not enough to have a good mind; the main thing is to use it well."
  },
  {
    "person": "Socrates",
    "quote":
        "The greatest way to live with honour in this world is to be what we pretend to be."
  },
  {
    "person": "Albert Einstein",
    "quote":
        "Try not to become a man of success but rather try to become a man of value."
  },
  {
    "person": "Buddha",
    "quote":
        "Your work is to discover your world and then with all your heart give yourself to it."
  },
  {
    "person": "Tony Robbins",
    "quote": "It is in your moments of decision that your destiny is shaped."
  },
  {
    "person": "",
    "quote": "An obstacle may be either a stepping stone or a stumbling block."
  },
  {
    "person": "Pierre Auguste Renoir",
    "quote": "The pain passes, but the beauty remains."
  },
  {
    "person": "Bob Newhart",
    "quote": "All I can say about life is, Oh God, enjoy it!"
  },
  {
    "person": "Rita Mae Brown",
    "quote":
        "Creativity comes from trust. Trust your instincts. And never hope more than you work."
  },
  {
    "person": "Lululemon",
    "quote":
        "Your outlook on life is a direct reflection on how much you like yourself."
  },
  {"person": "Kin Hubbard", "quote": "You won't skid if you stay in a rut."},
  {
    "person": "Mary Morrissey",
    "quote":
        "You block your dream when you allow your fear to grow bigger than your faith."
  },
  {"person": "Aristotle", "quote": "Happiness depends upon ourselves."},
  {
    "person": "Albert Schweitzer",
    "quote": "Wherever a man turns he can find someone who needs him."
  },
  {
    "person": "Maya Angelou",
    "quote":
        "If one is lucky, a solitary fantasy can totally transform one million realities."
  },
  {
    "person": "Leo Buscaglia",
    "quote":
        "Never idealize others. They will never live up to your expectations."
  },
  {
    "person": "Lao Tzu",
    "quote":
        "When you realize there is nothing lacking, the whole world belongs to you."
  },
  {
    "person": "Dalai Lama",
    "quote":
        "Happiness is not something ready made. It comes from your own actions."
  },
  {
    "person": "Peter Elbow",
    "quote": "Meaning is not what you start with but what you end up with."
  },
  {"person": "Anne Frank", "quote": "No one has ever become poor by giving."},
  {
    "person": "Mother Teresa",
    "quote":
        "Be faithful in small things because it is in them that your strength lies."
  },
  {"person": "Heraclitus", "quote": "All is flux; nothing stays still."},
  {
    "person": "Leonardo da Vinci",
    "quote": "He who is fixed to a star does not change his mind."
  },
  {
    "person": "Marcus Aurelius",
    "quote":
        "He who lives in harmony with himself lives in harmony with the universe."
  },
  {
    "person": "Sophocles",
    "quote":
        "Ignorant men don't know what good they hold in their hands until they've flung it away."
  },
  {
    "person": "Albert Einstein",
    "quote": "When the solution is simple, God is answering."
  },
  {
    "person": "Napoleon Hill",
    "quote":
        "All achievements, all earned riches, have their beginning in an idea."
  },
  {
    "person": "Publilius Syrus",
    "quote": "Do not turn back when you are just at the goal."
  },
  {
    "person": "Byron Pulsifer",
    "quote":
        "You can't trust without risk but neither can you live in a cocoon."
  },
  {
    "person": "Channing",
    "quote": "Error is discipline through which we advance."
  },
  {
    "person": "Pearl Buck",
    "quote":
        "The truth is always exciting. Speak it, then. Life is dull without it."
  },
  {
    "person": "Confucius",
    "quote":
        "The superior man is modest in his speech, but exceeds in his actions."
  },
  {
    "person": "Voltaire",
    "quote":
        "The longer we dwell on our misfortunes, the greater is their power to harm us."
  },
  {
    "person": "Cervantes",
    "quote": "Those who will play with cats must expect to be scratched."
  },
  {
    "person": "",
    "quote": "I've never seen a smiling face that was not beautiful."
  },
  {
    "person": "Aristotle",
    "quote": "In all things of nature there is something of the marvellous."
  },
  {
    "person": "Marcus Aurelius",
    "quote":
        "The universe is transformation; our life is what our thoughts make it."
  },
  {"person": "Samuel Johnson", "quote": "Memory is the mother of all wisdom."},
  {
    "person": "Confucius",
    "quote": "Silence is the true friend that never betrays."
  },
  {
    "person": "Napoleon Hill",
    "quote":
        "You might well remember that nothing can bring you success but yourself."
  },
  {
    "person": "Benjamin Franklin",
    "quote": "Watch the little things; a small leak will sink a great ship."
  },
  {
    "person": "William Shakespeare",
    "quote": "God has given you one face, and you make yourself another."
  },
  {
    "person": "Confucius",
    "quote": "To be wronged is nothing unless you continue to remember it."
  },
  {"person": "", "quote": "Kindness is the greatest wisdom."},
  {
    "person": "Tehyi Hsieh",
    "quote": "Action will remove the doubts that theory cannot solve."
  },
  {
    "person": "",
    "quote":
        "Don't miss all the beautiful colors of the rainbow looking for that pot of gold."
  },
  {
    "person": "Napoleon Hill",
    "quote": "Your big opportunity may be right where you are now."
  },
  {
    "person": "Chinese proverb",
    "quote":
        "People who say it cannot be done should not interrupt those who are doing it."
  },
  {
    "person": "Japanese proverb",
    "quote": "The day you decide to do it is your lucky day."
  },
  {
    "person": "Cicero",
    "quote": "We must not say every mistake is a foolish one."
  },
  {
    "person": "George Patton",
    "quote":
        "Accept challenges, so that you may feel the exhilaration of victory."
  },
  {
    "person": "Anatole France",
    "quote": "It is better to understand a little than to misunderstand a lot."
  },
  {
    "person": "",
    "quote": "You don't drown by falling in water. You drown by staying there."
  },
  {
    "person": "",
    "quote":
        "Never be afraid to try, remember... Amateurs built the ark, Professionals built the Titanic."
  },
  {
    "person": "Johann Wolfgang von Goethe",
    "quote": "Correction does much, but encouragement does more."
  },
  {
    "person": "Epictetus",
    "quote": "Know, first, who you are, and then adorn yourself accordingly."
  },
  {
    "person": "Oprah Winfrey",
    "quote":
        "The biggest adventure you can ever take is to live the life of your dreams."
  },
  {
    "person": "Charles Swindoll",
    "quote": "Life is 10% what happens to you and 90% how you react to it."
  },
  {
    "person": "Cynthia Ozick",
    "quote": "To want to be what one can be is purpose in life."
  },
  {
    "person": "Dalai Lama",
    "quote":
        "Remember that sometimes not getting what you want is a wonderful stroke of luck."
  },
  {
    "person": "Winston Churchill",
    "quote": "History will be kind to me for I intend to write it."
  },
  {
    "person": "Wayne Dyer",
    "quote": "Our lives are a sum total of the choices we have made."
  },
  {
    "person": "Leonardo da Vinci",
    "quote": "Time stays long enough for anyone who will use it."
  },
  {
    "person": "",
    "quote":
        "Never tell me the sky's the limit when there are footprints on the moon."
  },
  {
    "person": "Denis Waitley",
    "quote": "You must welcome change as the rule but not as your ruler."
  },
  {
    "person": "Jim Rohn",
    "quote":
        "Give whatever you are doing and whoever you are with the gift of your attention."
  },
  {
    "person": "Lena Horne",
    "quote": "Always be smarter than the people who hire you."
  },
  {
    "person": "Tom Peters",
    "quote": "Formula for success: under promise and over deliver."
  },
  {
    "person": "Henri Bergson",
    "quote": "The eye sees only what the mind is prepared to comprehend."
  },
  {
    "person": "Lee Mildon",
    "quote": "People seldom notice old clothes if you wear a big smile."
  },
  {
    "person": "Shakti Gawain",
    "quote":
        "The more light you allow within you, the brighter the world you live in will be."
  },
  {
    "person": "Walter Anderson",
    "quote": "Nothing diminishes anxiety faster than action."
  },
  {
    "person": "Andre Gide",
    "quote":
        "Man cannot discover new oceans unless he has the courage to lose sight of the shore."
  },
  {
    "person": "Carl Jung",
    "quote":
        "Everything that irritates us about others can lead us to an understanding about ourselves."
  },
  {
    "person": "Sun Tzu",
    "quote": "Can you imagine what I would do if I could do all I can?"
  },
  {
    "person": "Benjamin Disraeli",
    "quote": "Ignorance never settle a question."
  },
  {
    "person": "Paul Cezanne",
    "quote": "The awareness of our own strength makes us modest."
  },
  {
    "person": "Confucius",
    "quote":
        "They must often change, who would be constant in happiness or wisdom."
  },
  {
    "person": "Tom Krause",
    "quote":
        "There are no failures. Just experiences and your reactions to them."
  },
  {
    "person": "Frank Tyger",
    "quote": "Your future depends on many things, but mostly on you."
  },
  {
    "person": "Dorothy Thompson",
    "quote":
        "Fear grows in darkness; if you think theres a bogeyman around, turn on the light."
  },
  {
    "person": "Shunryu Suzuki",
    "quote":
        "The most important point is to accept yourself and stand on your two feet."
  },
  {
    "person": "Tomas Eliot",
    "quote":
        "Do not expect the world to look bright, if you habitually wear gray-brown glasses."
  },
  {
    "person": "Donald Trump",
    "quote": "As long as your going to be thinking anyway, think big."
  },
  {
    "person": "John Dewey",
    "quote": "Without some goals and some efforts to reach it, no man can live."
  },
  {
    "person": "Richard Braunstein",
    "quote": "He who obtains has little. He who scatters has much."
  },
  {
    "person": "George Orwell",
    "quote": "Myths which are believed in tend to become true."
  },
  {
    "person": "Buddha",
    "quote": "The foot feels the foot when it feels the ground."
  },
  {
    "person": "John Petit-Senn",
    "quote": "Not what we have but what we enjoy constitutes our abundance."
  },
  {
    "person": "George Eliot",
    "quote": "It is never too late to be what you might have been."
  },
  {"person": "Mary Wollstonecraft", "quote": "The beginning is always today."},
  {
    "person": "Sheldon Kopp",
    "quote":
        "In the long run we get no more than we have been willing to risk giving."
  },
  {
    "person": "Ralph Emerson",
    "quote": "Self-trust is the first secret of success."
  },
  {
    "person": "Satchel Paige",
    "quote": "Don't look back. Something might be gaining on you."
  },
  {
    "person": "Epictetus",
    "quote":
        "Men are disturbed not by things, but by the view which they take of them."
  },
  {
    "person": "",
    "quote":
        "A smile is a light in the window of your face to show your heart is at home."
  },
  {
    "person": "Pablo Picasso",
    "quote":
        "I am always doing that which I can not do, in order that I may learn how to do it."
  },
  {
    "person": "",
    "quote":
        "You may only be someone in the world, but to someone else, you may be the world."
  },
  {
    "person": "Tony Blair",
    "quote":
        "Sometimes it is better to lose and do the right thing than to win and do the wrong thing."
  },
  {
    "person": "Mother Teresa",
    "quote":
        "Let us always meet each other with smile, for the smile is the beginning of love."
  },
  {
    "person": "",
    "quote":
        "A bend in the road is not the end of the road...unless you fail to make the turn."
  },
  {
    "person": "Aristotle",
    "quote":
        "We are what we repeatedly do. Excellence, then, is not an act, but a habit."
  },
  {
    "person": "Ray Bradbury",
    "quote":
        "Living at risk is jumping off the cliff and building your wings on the way down."
  },
  {
    "person": "Laozi",
    "quote":
        "The power of intuitive understanding will protect you from harm until the end of your days."
  },
  {
    "person": "Abraham Lincoln",
    "quote":
        "The best thing about the future is that it only comes one day at a time."
  },
  {
    "person": "Epictetus",
    "quote":
        "We have two ears and one mouth so that we can listen twice as much as we speak."
  },
  {
    "person": "Byron Pulsifer",
    "quote":
        "Fear of failure is one attitude that will keep you at the same point in your life."
  },
  {
    "person": "Ed Cunningham",
    "quote":
        "Friends are those rare people who ask how we are and then wait to hear the answer."
  },
  {
    "person": "Ralph Waldo Emerson",
    "quote":
        "A hero is no braver than an ordinary man, but he is braver five minutes longer."
  },
  {
    "person": "Orison Marden",
    "quote":
        "The Creator has not given you a longing to do that which you have no ability to do."
  },
  {
    "person": "Sam Levenson",
    "quote":
        "It's so simple to be wise. Just think of something stupid to say and then don't say it."
  },
  {
    "person": "Doris Mortman",
    "quote":
        "Until you make peace with who you are, you will never be content with what you have."
  },
  {
    "person": "Buddha",
    "quote":
        "No one saves us but ourselves. No one can and no one may. We ourselves must walk the path."
  },
  {
    "person": "Mohandas Gandhi",
    "quote":
        "Happiness is when what you think, what you say, and what you do are in harmony."
  },
  {
    "person": "",
    "quote":
        "Courage is the discovery that you may not win, and trying when you know you can lose."
  },
  {
    "person": "Buddha",
    "quote":
        "When you realize how perfect everything is you will tilt your head back and laugh at the sky."
  },
  {
    "person": "Albert Einstein",
    "quote":
        "A man should look for what is, and not for what he thinks should be."
  },
  {
    "person": "W. H. Auden",
    "quote":
        "To choose what is difficult all ones days, as if it were easy, that is faith."
  },
];
