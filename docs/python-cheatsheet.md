# Python Cheat Sheet


## Basic Stuff


### Basic flow control structures


```python
def verify_max(predicted_max, list):
  for x in list:
    if (x > predicted_max):
      x = predicted_max
      break
    elif (x == predicted_max):
      break
  else:  # else after for/while/etc. executes when loop completes without break
    print(f'Found max: {predicted_max}')
```


### Ternary operator

```python
a if condition else b
a or b                                      # equivalent to "a if a else b"
```



## Functions


### Default function parameters

```python
def f(x, y = 0, z = 12):                    # callable with 1, 2, or 3 parameters
```


### Returning multiple values

```python
def my_function():
  return x, y, z
x, y, _ = my_function();                    # throw away unwanted values
```


### Function documentation

```python
def function_with_docstring():
  """Some info about the function."""       # add docstring (note triple quotes) - can be multiline
help(function_with_docstring)               # print docstring
```


Function attributes: Property of a function that can be checked after the function executes:
```python
def f(var):
  f.myattribute = var                       # create attribute for function f
  return var * 12
x = f(9)
x += f.myattribute                          # use attribute after executing f
```


### Star tuple: Joins all following items into a tuple

```python
def x(a, b, c, *args):                      # for arguments starting with the fourth, provide as a tuple
  result = y(*args)                         # unpack the *args tuple and calls y on each of them
```


Generator function: Function that runs for a while, yields a value, and stops; next invocation causes execution to resume from same point until another value is yielded
```python
def ints(start, end):
  i = start
  while i <= end:
    yield i                                 # stop execution and returns i, until next invocation of ints
    i = i + 1
k = ints(1, 10)                             # return an instance of the generator function
while next(k):                              # iterate once and yields a value (Python 3: next(k), not k.next())
  print(k)
for j in ints(1, 10):                       # iterate until the function stops producing values
  print(j)
```



## Data Structures


### Lists

```python
len(list)                                   # list length
list[3:5]                                   # list slice
list.append(x)                              # append x to list
list.extend([x, y, z])                      # concatenate list to list
list.insert(5, x)                           # insert at specific position
list.remove(x)                              # remove element x
del list[5]                                 # remove element at position
x = list.pop()                              # pop last element
x = list.pop(0)                             # pop element (i)
list.index(3)                               # return index of first element with the value 3
list.count(3)                               # return the number of 3's in the list
list.sort(key=len)                          # sort list by length
list = sorted(list, key=len)                # return copy of list sorted by len in ascending order
list = sorted(list, key=len, reverse=True)  # return copy of list sorted by len in descending order
list = sorted(list, key=lambda s: len(s))   # return copy of list sorted by lambda expression
```


### Dictionaries

```python
d = {'key': value}                          # create dictionary
d['key']                                    # look up value from dictionary
d.get('key', default_value)                 # retrieve the value or a default value
d.setdefault('key', value)                  # set value only if key does not already exist
for key in d:                               # iterates over keys
for value in d.values():                    # iterates over values
for key, value in d.items():                # iterates over both keys and values
del d['key']                                # remove key from dictionary
'1' in d                                    # test whether value is in dictionary keys
'2' in d.values()                           # text whether value is in dictionary values
d1.update(d2)                               # add dictionary d2 to dictionary d1
d3 = {**d1, **d2}                           # create new dictionary as union of d1 and d2 (d1, d2 are unchanged)
pprint.pprint(d, indent=2)                  # pretty-print a dictionary with each key:value pair on a new line
x = sorted(d, key=lambda x: d[x])           # sort dictionary d by values (add 'reverse = True' for reverse order)
```


### Default dictionaries (collections)

```python
x = collections.defaultdict(list)           # creates a dictionary that defaults to an empty list
x['foo'].append('bar')                      # x['foo'] = ['bar']
```


### Ordered dictionaries (collections)

```python
x = collections.OrderedDict()               # same as {}, but keys are always returned in insert order
                                            # NOTE: regular dicts preserve insertion order in Python 3.7+
```


### Strings

```python
'{} and {}'.format(x, y)                    # string generation (types: i=integer, f=float, s or empty=string)
s[2:5]                                      # string slice
s.find('asdf')                              # return index of substring or -1 if not found
s.startswith('asdf')                        # test whether string starts with substring
s.endswith('asdf')                          # test whether string ends with substring
s.lower()                                   # return lowercase version of string
s.isnumeric()                               # test whether string is a number
int(s)                                      # convert string to integer
s.strip()                                   # strip leading and lagging whitespace
s.split('token')                            # split string on token
s.splitlines()                              # split string on all newlines
' '.join(list)                              # join list items using token
s.replace('a', 'b')                         # replace all instances of a with b
s.ljust(5)                                  # left-adjust to length of 5 with trailing spaces
s.rjust(5)                                  # right-adjust to length of 5 with leading spaces
s.center(5)                                 # center to length of 5 with spaces
s.zfill(5)                                  # left-pad with leading zeros to length of 5
```


### Common Formatted Strings

```python
f'{x:,}'                                    # x formatted with comma separators
f'{x:.0f}'                                  # float x rounded to int
f'{x:.2f}'                                  # float x rounded to two decimal places
f'{x:,.2f}'                                 # both commas and decimal-place rounding
f'{x:.2%}'                                  # float x displayed as percentage
f'{x:5}'                                    # number x, right-justified, with space padding to five spaces
f'{x:<5}'                                   # number x, left_justified, with space padding to five spaces
f'{x:^5}'                                   # number x, center-justified, with space padding
f'{x:*^5}'                                  # number x, center-justified, with asterisks padding
f'{x:*<5}'                                  # number x, left-justified, with asterisks padding
f'{d:%m/%d/%Y}'                             # datetime d, displayed as two-digit month/two-digit day/four-digit year
f'{d:%H:%M:%S %p}'                          # datetime d, displayed as hour:minute:second AM/PM
f'{d:%Y%m%d %H:%M:%S %p}'                   # datetime d, displayed as complete date/time string
```


### Parameterized String Formatting

```python
'{} + {}'.format('x', 'y')                  # default ordering --> 'x + y'
'{1} + {0}'.format('x', 'y')                # positional ordering --> 'y + x'
```


### Queues (great for multithreading)

```python
q = queue.Queue()                           # variations: queue.LifoQueue (i.e., a stack); queue.PriorityQueue (sorted)
q.put(message)                              # push - note: queues have max size; if queue is full, this call blocks
q.get(message)                              # pop - note: typically blocks if empty
q.get(message, timeout=60)                  # pop with timeout, after which queue.Empty gets thrown
q.empty()                                   # returns empty or not
```


### Sets

```python
a = set()                                   # creates new, empty set
a = {'1', '2', '3'}                         # creates set with three values
'1' in s                                    # True
sorted(a)                                   # returns sorted list
s.add('4')                                  # add value to list
s.discard('2')                              # remove value from list
s.remove('2')                               # same as discard(), but raises an exception if value is not in set
s.pop()                                     # returns and removes an empty element from set
s.clear()                                   # remove all elements
s.update(t)                                 # s = s OR t
s.intersection_update(t)                    # s = s AND t
s.difference_update(t)                      # s = s AND NOT t
s.symmetric_difference_update(t)            # s = s XOR t
```


### Time (time)

```python
time.time()                                 # get current time
time.sleep(1)                               # sleep for 1 second
```


### Date (datetime)

```python
today = datetime.date.today()               # get current date
d = '20210101'                              # date string, %Y%m%d format
day = datetime.datetime.strptime(d, '%Y%m%d').date()  # get date from date string
diff = (today - day).days                   # get number of days between days (note: .days is a property, not a method)
```


### DateTime (datetime)

```python
now = datetime.datetime.now()               # get date tuple: (y, m, d, h, m, s)
duration = (now - yesterday).days           # calculate difference in days
delta = datetime.timedelta(days=1)          # generate time delta object
f'{delta.seconds//3600:02}:{delta.seconds//60%3600:02}'   # convert to hh:mm
tomorrow = now + one_day                    # add time delta to time object
datetime.datetime.fromtimestamp(int)        # convert int to date tuple
t = now.strftime('%m %d, %Y')               # convert date tuple to string
time = datetime.datetime.strptime(t, format)  # convert time string to datetime object
                                            # formats:   %Y, %y      year (2014, or 14)
                                            #            %m, %B, %b  month (01, January, Jan)
                                            #             %d, %j      day (month, year)
                                            #            %w, %A, %a  weekday (0, Sunday, Sun)
                                            #            %H, %I, %p  hour (24-hour, 12-hour, AM/PM)
                                            #            %M          minute
                                            #            %S          second
                                            #            %f          microsecond
                                            #            %c          Local version of date and time  Mon Dec 31 17:41:00 2018
                                            #            %x          Local version of date    12/31/18
                                            #            %X          Local version of time  17:41:00
                                            #            %U          Week number of year, Sunday as the first day of week, 00-53\
                                            #            %W          Week number of year, Monday as the first day of week, 00-53
```

datetime.today().strftime('%Y%m%d')           # date stamp

### Enum (enum)

```python
class Foo(enum.Enum):
  bar = 1; baz = 2
a = Foo.bar                                 # assignment
a                                           # evaluates to <Foo.bar: 1>
```



## Classes and Objects


### Basic class structure

```python
class MyClass:
  def __init__(self, initial_value):
    self.internal_value = initial_value
  def __str__(self):                        # printable representation of object
    print(f'State: {self.internal_value}')
  def __repr__(self):                       # unambiguous printable representation of object state
  def __call__(self):                       # default function - called if object() is called
x = MyClass()                               # instantiate class via __init__
x()                                         # invoke default function
```


### Static and class methods

```python
class MyClass:
  i = 4                                     # defines a class variable (access as MyClass.i)
  @staticmethod                             # defines the next function as a static class method
  def f1(x):                                # call as MyClass.f1(x) (no class instance required)
  @classmethod                              # defines a class method
  def f2(cls, x):                           # call as y.f2(x) where y is an instance of MyClass
      # "cls" is automatically added to function call to identify the class. Can be overridden in
      # derived classes. Can access class variables (e.g., cls.i), etc.
```


### Object reflection and type inference

```python
type(x)                                     # type of object x
type(x) is list                             # is x a list (NOTE: 'x is list' is wrong)
isinstance(x, int)                          # is x an instance of a variable or class
hasattr(x, 'property_name')                 # check whether class has a property of this name
y = getattr(x, 'property_name')             # get property by name
setattr(x, 'property_name', 12)             # set property name
dir(x)                                      # list of members of x
list((y, type(getattr(x, y))) for y in dir(x))    # list of member names and types of object x
globals()['class name']                     # get class object by name
o = globals()['class name']()               # create instance with default constructor
```


### Inheritance

```python
class ParentClass:                          # parent class
  def __init__(self, x):
    assert(type(self) is not ParentClass)   # throw assert exception if trying to init parent class
class ChildClass (ParentClass):             # subclass
  def __init__(self, x):
    super().__init__(x)                     # call parent class init with parameter x
```


### Object cleanup (atexit)

```python
def __init__(self):
  atexit.register(self.cleanup)             # register cleanup function
def cleanup(self):                          # run cleanup
```



## Comprehension and Iteration


### List comprehension

```python
[x + 3 for x in my_list]                    # return a list of every value incremented by 3
[x for x in list if x > 3]                  # return a list of values greater than 3
[x if x > 3 else 0 for x in list]           # return a list of values greater than 3; 0 otherwise
for x in (x for x in my_list if x > 2):     # iterate over list with condition
[x > 3 for x in my_list]                    # return subset with criteria
[x for y in [[1, 2], [3, 4]] for x in y]    # two-tier list comprehension: return [1, 2, 3, 4]
any(x > 3 for x in my_list)                 # test whether one or more elements of list meet criteria
all(x > 3 for x in my_list)                 # test whether all elements of list meet criteria
for i, x in enumerate(my_list):             # iterate over list with enumeration (i = index)
                                            # NOTE: it's OK to change my_list during enumeration
for a, b in zip(list_1, list2):             # iterate over two lists at the same time
for x in filter(lambda x: x > 3, my_list):  # iterate over elements of list that match condition > 3
a, b, *c = [1, 2, 3, 4, 5]                  # split the list into a=1, b=2, and c=[3, 4, 5]
a, *b, c = [1, 2, 3, 4, 5]                  # split the list into a=1, b=[2, 3, 4], and c=5
```


### Dictionary comprehension

```python
{x: x+3 for x in [2, 4, 6]}                 # returns dictionary: {2: 5, 4: 7, 6: 9}
for k, v in my_dictionary.items():          # iterate over key/value pairs together (Python 3)
```


### Generator functions

```python
x = iter(my_list)                           # turn an iterable into a generator function
next(x)                                     # return next value from generator
y = list(x)                                 # turn generator function into list
```


Remember: (...) returns a generator; [...] returns a list.


## Regular Expressions / RegEx


### Example

```python
import re
m = re.search('(\d{3})[-\s]?\d{3}-?\d{4}', '1234sdf 123-456-7890')
if m is not None:
  print(f'Full phone number: {m.group(0)} Area code: {m.group(1)}')
```


### Matching functions

```python
m = re.search(pattern, text)                # search for pattern; return match object or None
m.group(0)                                  # return entire matching string
m.group(1)                                  # return string for first match group
m.start(1), m.end(1)                        # start/end position of matched part of text for group 1
m.span(1)                                   # tuple of (start, end) for group 1
re.match(pattern, text)                     # search for pattern *FROM BEGINNING OF TEXT*; return match object or None
re.findall(pattern, text)                   # search for non-overlapping matches
    # If pattern contains one group, returns list of strings; if multiple groups, returns list of *tuples* of strings
re.finditer(pattern, text)                  # search for non-overlapping matches; return iterator of Match objects
re.split(pattern, text)                     # split on token pattern specifying token
re.sub(pattern, r, text)                    # replace all non-overlapping instances of pattern with r
re.sub(pattern, r, text, n)                 # replace (n) left-most non-overlapping instances of pattern with r
```


### Compiled regex

```python
c = re.compile('(\d)\d+')                   # compile regex
results = c.search(text)                    # apply compiled regex to match text
replace = c.sub('\1', text)                 # substitution: \1 refers to first match group, etc.
```



## Threading


### Scheduled function call

```python
t = Timer(30, my_function)                  # run named function after 30 seconds
t.start()
```


### Simple threading (thread)

```python
thread.start_new_thread(my_function, (arg)) # instantiate thread with function and arguments
```


More sophisticated thread that allows status checking, termination, etc. (threading):
```python
t1 = threading.Thread(target=my_function, args=(arg1, arg2))      # note: args must be a tuple
t1.daemon = False                           # if script ends while only daemon threads are alive,
                                            # script will terminate and daemon threads are terminated
t1.start()                                  # starts thread at my_function
class MyThread(threading.Thread):
  def run(self):                            # thread execution starts here
t2 = MyThread()
t2.start()                                  # invoke t2.run()
t2.is_alive()                               # check status
t2.join()                                   # block calling thread until t2 terminates
t2.exit()                                   # exits thread
```


### Events

```python
event = threading.Event()
event.set()                                 # set event
event.clear()                               # clear event
event.is_set()                              # check whether set
event.wait()                                # block until set (can specify a timeout as a parameter)
```


### Locks

```python
lock = threading.Lock()
lock.acquire()                              # can specify a timeout value
lock.release()
with lock: ...
```



## File I/O


### Read file (os)

```python
file = open(filename, 'w'); file.close()
with open(filename, 'r') as my_file:
  contents = my_file.read()                 # returns all content; could specify a number of bytes
  my_file_lines = my_file.readlines()       # returns a list
  line = my_file.readline()                 # returns one line ending with \n, and "" at EOF
```


### Write file (os, codecs)

```python
path = os.path.abspath('file.txt')                      # file in current directory
with codecs.open(path, 'w+', 'utf-8') as output_file:
  output_file.write(file_contents)                      # if writing a string, probably append \n
sys.stdout.write('\r Erase Text'); sys.stdout.flush();  # carriage return before output (erasable text)
```

Modes: r = read, r+ = read/write, w = write/create, w+ = read/write/create, a = append, a+ = read/append

### Write temporary file (os, tempfile)

```python
with tempfile.NamedTemporaryFile(suffix='.html', mode='wt', delete=False) as file:
  file.write(html)
  os.system(f'open "{file.name}"')
```


### Misc file stuff (os)

```python
os.path.dirname(os.path.realpath(__file__)) # return path of currently executing script
os.path.isfile(path)                        # test existence of file
os.path.isdir(path)                         # test existence of folder
os.listdir(path)                            # list files at specified path
os.path.dirname(path)                       # return directory part of path
os.path.basename(path)                      # returns filename part of path
os.path.expanduser('~/a.txt')               # expand ~ to actual path
shutil.move(file, path)                     # move file
os.unlink(file)                             # delete file
shutil.rmtree(path, ignore_errors=True)     # delete folder and all subfolders
os.walk(path)                               # return list of path contents
os.getcwd()                                 # return current working directory
os.chdir(path)                              # change working directory
os.path.getsize(filename)                   # return file size in bytes
  # to display size in megabytes, use '{0:,.1f}'.format(os.path.getsize(filename) / 1000000.0)
os.path.join
os.abspath
```

### File directory search (glob)

```python
files = glob.glob('/*.txt')                 # provide list of matching files in specified location
```


### File compression (zipfile, os)

```python
zip = zipfile.ZipFile(filename)             # load zip file into memory
zip.namelist()                              # list zip contents
zip.extract(filename)                       # extract file to current directory
zip.extract(filename, path)                 # extract file to path
zip.extractall()                            # extract zip to current directory
zip = zipfile.ZipFile(filename, 'w')        # create new zipfile (can include 'a' to append)
zip.write(filename, compress_type = zipfile.ZIP_DEFLATED)      # add file to zip
zip.close()                                 # close
```


### Reading CSV files (csv)

```python
with open(filename) as f:
  reader = csv.reader(f)
  for row in reader: ...                    # row = list of values
```


### Unicode (unicodedata)

```python
if isinstance(s, unicode):
  s = unicodedata.normalize('NFKD', s).encode('ascii', 'ignore')
```


### JSON serialization / deserialization

```python
my_object = json.loads(json_string)         # decode object from JSON string
my_object = json.load(open_file)            # read from open file
json_string = json.dumps(my_object)         # encode object as JSON string
json.dump(json_string, open_file)           # write to open file
```


### Instantiate class from JSON string (json)

```python
class MyClass:
  def __init__(self, dict_):
    self.__dict__.update(dict_)
c = MyClass(json.loads(s))                  # instantiate directly object from JSON string
with open('f.txt', 'wt') as f:
  f.write(json.dumps(c))
```


### Object serialization (pickle)

```python
with open(filename, 'wb') as f:
  pickle.dump(my_instance, f)
with open(filename, 'rb') as f:
  my_instance = pickle.load(f)
```


### Save a set of instances to a file

```python
i = ['a', 'b', 'c']                         # names of objects to save
d = {x: getattr(sys.modules[__name__], x) for x in i}    # create dictionary of state objects
with open(filename, 'wb') as f:
  pickle.dump(d, f)
with open(filename, 'rb') as f:
  d = pickle.load(f)
for x in d:
  setattr(sys.modules[__name__], x, d[x])   # create global instance of each object with name
```



## Console I/O


Detect availability of a line of console input (does not work on Windows):
```python
result = select.select([sys.stdin], [], [], 0.01)
return (sys.stdin in result[0])
```


### Read a line from stdin

```python
sys.stdin.readline()
response = input('Enter a command: ')       # retrieves console input (blocking call)
```


### Flush stdin

```python
while sys.stdin in select.select([sys.stdin], [], [], 0.001)[0]:
  sys.stdin.read(1)
```


Read a single character: Use the getch.py example (cross-platform, etc.), then:
```python
from getch import getch
a = getch()
```


### Write line to output repeatedly: Just don't use a line feed

 print(f'\r{text}', end="")


## Communication


### Web (requests)

```python
r = requests.get(url, timeout=5).text          # return text from GET request for URL
    # NOTE: Best to include a timeout on every request. Some websites hang onto session after delivering all data.
r.status_code                                  # HTTP status code (200 = OK, etc.)
lp = requests.auth.HTTPBasicAuth('username', 'password')    # basic authentication credentials
r = requests.get(url, auth=lp)                 # GET with basic authentication username/password
r = requests.get(url, params={'a': 'b'})       # GET with parameters
r = requests.post(url, data={'a': 'b'})        # POST with parameters
r = requests.put(url, data={'a': 'b'})         # PUT with parameters
```

# delegate handler:
```python
def my_handler(r, *args,  **kwargs):           # define handler function (r is same as above)
h = dict(response=my_handler)                  # specify handler for response
r = requests.get(url, hooks=h)                 # GET request with handler
```

# streaming data directly to disk:
```python
try:
  response = requests.get(url, timeout=5, stream=True)
  response.raise_for_status()
  with open(filename) as file:
    for block in response.iter_content(1024):
      file.write(block)
except Exception as e:
  print(e)
```

# more info: https://2.python-requests.org/en/master/
# examples:  https://realpython.com/python-requests/#other-http-methods

### Web (urllib)

```python
parameters = urllib.parse.urlencode(params)          # encode dictionary of parameters as ?a=b&c=d
f = urllib.request.urlopen(url + '?' + parameters)   # initiate request via HTTP GET
f = urllib.request.urlopen(url, parameters.encode())  # initiate request via HTTP POST
f.read()                                             # read contents
urllib.request.urlretrieve(url, filename)            # retrieve resource and save as filename
s = urllib.parse.quote_plus(s)                       # encode URL symbols: %20, etc.
s = urllib.parse.unquote_plus(s).strip()             # decode URL symbols ('plus' = also encode spaces)
```


SMB (pysmb, installable via pip)
```python
c = SMBConnection(username, password, local_computer_name, remote_computer_name)
c.connect(ip_address, port)                    # connect (default port is 139)
c.listShares()                                 # list of shared top-level folder
d = c.listPath(share, path)                    # list of SharedFile objects
list(f.filename for f in d)                    # list of filenames of objects
c.createDirectory(share, path)                 # create directory
c.deleteDirectory(share, path)                 # delete directory
c.deleteFiles(share, pattern)                  # delete files matching pattern
c.rename(share, old, new)                      # renames file or folder
with open(filename, 'wb') as f:
  c.retrieveFile(share, path, f)               # retrieve file
with open(filename, 'rb') as f:
  c.storeFile(share, path, f)                  # store file
c.close()                                      # close connection
```

# more info: https://pythonhosted.org/pysmb/api/smb_SMBConnection.html

### Simple text email (smtplib, email.mime.text)

```python
s = smtplib.SMTP('smtp.gmail.com', 587)
s.ehlo(); s.starttls(); s.ehlo()
s.login(sender, password)
s.sendmail(sender, recipient, 'Subject: Some Subject Text\n\n' + '\n'.join(report))
s.close()
```

# NOTE: to make this work with Gmail, the account must have "allow access by less secure apps" turned on.

HTML text email (smtplib, email.mime.text, email.mime.multipart):
```python
message = email.mime.multipart.MIMEMultipart('alternative')
message['Subject'] = 'Some Subject Text'
message['From'] = 'sender@email'; message['To'] = 'recipient@email'
part1 = email.mime.text.MIMEText('My Text Message', 'plain')
part2 = email.mime.text.MIMEText('<H1>My HTML Message</H1>', 'html')
message.attach(part1); message.attach(part2)
s = smtplib.SMTP()
s.connect('smtp.gmail.com', '587'); s.ehlo(); s.starttls()
s.login('sender@email', password)
s.sendmail('sender@email', 'recipient@email', message.as_string())
s.close()
```


### Telnet (telnetlib)

```python
tn = telnetlib.Telnet('127.0.0.1', '80')
tn.write('output some string\n')
response = tn.read_until('\n')
```


### SSH (paramiko)

```python
client = paramiko.SSHClient()
client.load_system_host_keys()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect('127.0.0.1', 'username', 'password')
client.exec_command('some ssh command')
result = []
for line in stdout:
  result.append(line.strip('\n'))
client.close()
```


### Interprocess communication

```python
  (1) Use named pipes. A server process opens a pipe with a specified name, which is an in-memory stream that behaves like a file. A client process can open the same pipe with the same name and write into it. See "Named Pipe" server/client example.
  (2) Use multiprocessing.Queue. There are some nuances here - e.g., empty() is broken (will frequently return True even when qsize() > 0; also, terminating processes may hang if they've still got data stored in a queue) - but generally works okay. However, this is only feasible for commonly started processes, where process (A) can hand the queue off to process (B). If a process cannot start
```


Socket-based client/server: See "socket_server.py" and "socket_client.py" examples.

Machine-to-machine communication: See "mqtt_pub.py" and "mqtt_sub.py" examples.

SMS communication: See "twilio_example.py" example.


## Media


Text-to-speech via the Google text-to-speech API (gtts, installable via pip):
```python
from gtts import gTTS                       # specific import string
tts = gTTS(text='Hello', lang='en')         # generate audio
tts.save('hello.mp3')                       # save audio as MP3
```



## Meta


### Evaluate a string containing Python code

```python
eval(string, dictionary_of_variables)
```


### Apply a function to each member of a list

```python
list(map(my_function, b))
```


### Apply a custom function to every member of an iterable

```python
map(lambda t: (t + 2), [1, 2, 3])
```


### Get the next value of generator function x (including map)

```python
next(x)
```


Lambda functions can only be an expression - must evaluate to a value, not return a value. A lambda function can accept a dictionary of arguments.
```python
def create_function(s):
  return lambda t: eval(s, t)               # lambda function invokes string s with parameters t
x_function = create_function('x + 2')       # create instance of lambda function for expression = 'x + 2'
print(x_function ( { 'x': 6 } ) )           # invoke lambda function instance with parameter list
```


### Call a local function with a name specified by a string

```python
sys.modules[__name__].__dict__['my_function'](a, b)    # invokes my_function(a, b)
```



## OS Interface


### Print to stdout

```python
print(f'string {some_integer}')
```


### Parameterized printing

```python
print('{var1} = {var2}'.format(var1=x, var2=y))
print('x = {}, y = {}'.format(x, y))
```


### Web browser (webbrowser)

```python
webbrowser.open('file://my.txt', new=2)
```


### OS shell command calls (os)

```python
os.system('some_command')
```


### OS shell command call with output retrieval (subprocess)

```python
output = subprocess.check_output(command.split()).decode('utf-8').split('\n')
  # this supports simple commands - for commands with pipes, use this:
with subprocess.Popen(['command', 'param1'], stdout=subprocess.PIPE, shell=True) as process:
  output = process.stdout.read().decode('utf-8').split('\n')
process.kill()    # explicitly kill a process
```


### OS clipboard (pyperclip)

```python
pyperclip.copy('some_text')                 # put string on clipboard
pyperclip.paste()                           # retrieve clipboard contents
```


### Set application to background and remove dock icon

```python
from AppKit import NSBundle
NSBundle.mainBundle().infoDictionary()["LSUIElement"] = "1"    # 0 = foreground
```



## Argument Parsing


### Command-line parameters list

```python
sys.argv
```


### Automated parsing (argparse)

```python
parser = argparse.ArgumentParser(description='description of script', epilog='ending comments')
parser.add_argument('a', type=int, help='Mandatory parameter a')
parser.add_argument('-b', choices=['x', 'y', 'z'], help='Optional with specific options')
parser.add_argument('-c', action='store_true', help='Optional flag (either True or False)')
parser.add_argument('-d', type=int, default=2, help='Optional integer (default = 2)')
parser.add_argument('-e', type=int, nargs='?', const=1, help='Optional int: either None, default value, or specified value')
parser.add_argument('--my_f', type=str, default='asdf', help='Optional string (default = "asdf")')
parser.add_argument('-g', nargs='*', help='Optional list of 0 or more arguments')    # or use + to require 1)
args = parser.parse_args()      # values are accessible as args.a, or as vars(args)['a']
```


```python
# flexible Boolean parameter: can be omitted, specified as any of these values for True, otherwise False
parser.add_argument('-verbose', nargs='?', type=str2bool, const=True, default=False, help='some boolean')
def str2bool(v): return (v.lower() in ('yes', 'true', 't', 'y', '1'))
```


See: "argparse_example.py" example.


## Code Documentation


### Getting information in Python

```python
help(other_function)
```


### Getting information via Bash

```python
python3 -c 'import my_file; help(my_function)'
```


### Basic example

```python
class MyClass1(object):
  """ This is my class. """                 # simple docstring format; can be multiline
  def my_function(self):
    """ This is my_function. """
```


### Google-style comment example

```python
def other_function(self, x):
  """Explanation of function.
```


```python
  Extended description of functionality of function.
```


```python
  Args:
    x (int): First parameter description.
    y (string): Second parameter description.
```


```python
  Returns:
    bool: The return value. True for success, False otherwise.
```


```python
  """
```


Markup text types: *italics*, **bold**, ``code example``, `hyperlink`

### More info

https://sphinxcontrib-napoleon.readthedocs.io/en/latest/example_google.html
https://thomas-cokelaer.info/tutorials/sphinx/rest_syntax.html


## GPIO (gpiozero)


### Basic commands

```python
button = gpiozero.Button("BOARD3")                  # "BOARD" = physical pinouts; can also use BCM
button.is_pressed
button.wait_for_press()
button.when_pressed = press                         # calls press() - see also: when_released
button.hold_time = 2; button.when_held = held       # calls held() after being held for two seconds
button.pull_up = True                               # default: pull-up resistor = active low + ground other terminal
button.bounce_time = 0.2                            # set debouncing
button.hold_repeat = True                           # repeats calls every hold_time seconds
```


### LED

```python
led = gpiozero.LED("BOARD5")
led.on()
led.is_active
led.pwm = True; led.value = 0.2                     # sets to PWM and variable brightness
```



## SQLite


### Basic commands

```python
db = sqlite3.connect('db.sqlite')                   # open connection
row = db.execute('select...').fetchone()            # fetch one record (provided as a tuple)
x = db.execute('select count(*)...').fetchone()[0]  # retrieve single value from first record
records = db.execute('select...').fetchall()        # select all records (may be slow)
db.execute('update my_table set...')                # simple imperative statement
db.commit()                                         # commit changes to record
db.close()                                          # close connection
```


### Schema commands

```python
db.execute('select name from sqlite_master').fetchall()
                                                    # list of table names
schema = db.execute('select sql from sqlite_master where tbl_name = "my_table"').fetchone()[0]
columns = schema.replace(')', '').split(',')        # get a list of attributes for table
db.execute('create table people (id integer primary key autoincrement, name text, ssn integer')
                                                    # create table with autoincremented ID field
db.execute('insert into people values (null, ?, ?)', (first_value, second_value,))
                                                    # safe insertion method for string values
records = [('Joe', 'Smith'), ('Mark', 'Baker')]     # example records
db.executemany('insert into people values (?, ?)', records)    # insert lots of records at once
db.execute('drop table if exists people')           # conditional drop
db.execute('vacuum')                                # compact database after deletions (may be slow)
```


### Cursor

```python
c = db.cursor(); c.execute('select...')
row = c.fetchone()
while row is not None: ...                          # note: row-count property for select queries
  row = c.fetchone()
c.close()
```


### Indexing

```python
db.execute('create index my_index on my_table(my_attribute)')
```


### Text-searchable fields

```python
CREATE VIRTUAL TABLE patent_search USING fts5(patent_number, description);
INSERT INTO patent_search SELECT patent_number, description FROM patents;
SELECT patent_number FROM patent_search WHERE description MATCH 'database and neural';
SELECT patent_number FROM patent_search WHERE description MATCH 'NEAR(database neural, 1)';
```



## Machine Learning / AI (Starter)


### Key concepts

```python
Model          A function trained on data to make predictions
Features (X)   Input variables (columns) used to make a prediction
Labels (y)     The target value you're trying to predict
Training       Fitting the model to data so it learns patterns
Inference      Using a trained model to make new predictions
Overfitting    Model memorizes training data but fails on new data
Epoch          One full pass through the training dataset
Batch size     Number of samples processed before weights are updated
Loss           A score measuring how wrong the model's predictions are
Optimizer      Algorithm that adjusts weights to reduce loss (e.g. Adam)
```


### Scikit-learn — ML pipeline and additional algorithms

```python
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.compose import ColumnTransformer
from sklearn.linear_model import LinearRegression, Ridge, Lasso
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import GradientBoostingClassifier
from sklearn.svm import SVC
from sklearn.cluster import KMeans
from sklearn.model_selection import GridSearchCV
```


```python
# Pipeline: chain preprocessing + model so test data never leaks into training fit
pipe = Pipeline([
  ('scaler', StandardScaler()),
  ('model', RandomForestClassifier())
])
pipe.fit(X_train, y_train)
pipe.predict(X_test)
```


```python
# Preprocessing mixed column types
pre = ColumnTransformer([
  ('num', StandardScaler(), numeric_cols),
  ('cat', OneHotEncoder(), categorical_cols)
])
```


```python
# Hyperparameter tuning via grid search
params = {'model__n_estimators': [50, 100], 'model__max_depth': [3, 5]}
grid = GridSearchCV(pipe, params, cv=5, scoring='accuracy')
grid.fit(X_train, y_train)
grid.best_params_                                # best parameter combination found
grid.best_score_                                 # best CV score
```


```python
# Unsupervised: K-Means clustering
km = KMeans(n_clusters=3, random_state=42)
km.fit(X)
km.labels_                                       # cluster assignment per sample
km.cluster_centers_                              # centroid coordinates
```


### Keras / TensorFlow — neural networks

```python
import tensorflow as tf
from tensorflow import keras
```


```python
# Build a simple feedforward network
model = keras.Sequential([
  keras.layers.Dense(128, activation='relu', input_shape=(n_features,)),
  keras.layers.Dropout(0.2),                     # randomly zero 20% of neurons to reduce overfitting
  keras.layers.Dense(64, activation='relu'),
  keras.layers.Dense(1)                          # 1 output for regression
])
# For binary classification: Dense(1, activation='sigmoid')
# For multi-class (n classes): Dense(n, activation='softmax')
```


```python
model.compile(
  optimizer='adam',
  loss='mse',                                    # regression: 'mse'
  # loss='binary_crossentropy',                  # binary classification
  # loss='sparse_categorical_crossentropy',      # multi-class classification
  metrics=['mae']                                # tracked but not optimized
)
```


```python
model.summary()                                  # print layer shapes and parameter counts
```


```python
history = model.fit(
  X_train, y_train,
  epochs=50,
  batch_size=32,
  validation_split=0.2,                          # hold out 20% of training data for validation
  verbose=1
)
```


```python
model.evaluate(X_test, y_test)                   # returns loss and metrics on test set
y_pred = model.predict(X_test)                   # run inference
```


```python
# Plot training curve to diagnose overfitting
import matplotlib.pyplot as plt
plt.plot(history.history['loss'], label='train')
plt.plot(history.history['val_loss'], label='val')
plt.legend(); plt.show()
```


```python
model.save('model.keras')                        # save model to disk
model = keras.models.load_model('model.keras')   # reload saved model
```


```python
# Convolutional network for images
model = keras.Sequential([
  keras.layers.Conv2D(32, (3, 3), activation='relu', input_shape=(28, 28, 1)),
  keras.layers.MaxPooling2D((2, 2)),
  keras.layers.Flatten(),
  keras.layers.Dense(64, activation='relu'),
  keras.layers.Dense(10, activation='softmax')   # 10 output classes
])
```


### Hugging Face Transformers — pre-trained models

```python
from transformers import pipeline
```


```python
# Sentiment analysis
classifier = pipeline('sentiment-analysis')
classifier('I love this!')                       # [{'label': 'POSITIVE', 'score': 0.999}]
```


```python
# Text generation
gen = pipeline('text-generation', model='gpt2')
gen('Once upon a time', max_new_tokens=50)
```


```python
# Named entity recognition
ner = pipeline('ner', grouped_entities=True)
ner('John lives in New York')                    # entities with type and confidence
```


```python
# Zero-shot classification (no training needed — just provide candidate labels)
zsc = pipeline('zero-shot-classification')
zsc('My laptop won\'t turn on',
    candidate_labels=['tech support', 'billing', 'general inquiry'])
```


```python
# Question answering
qa = pipeline('question-answering')
qa(question='What is the capital of France?',
   context='France is a country. Its capital is Paris.')
```


```python
# Embeddings (semantic similarity, search, clustering)
from sentence_transformers import SentenceTransformer
embedder = SentenceTransformer('all-MiniLM-L6-v2')
vecs = embedder.encode(['hello world', 'hi there'])  # returns numpy arrays
# cosine similarity between two vectors:
from sklearn.metrics.pairwise import cosine_similarity
cosine_similarity([vecs[0]], [vecs[1]])
```


### Claude API (Anthropic)

```python
import anthropic
client = anthropic.Anthropic()                   # reads ANTHROPIC_API_KEY from environment
```


```python
# Basic message
msg = client.messages.create(
  model='claude-sonnet-4-6',
  max_tokens=1024,
  messages=[{'role': 'user', 'content': 'Explain gradient descent simply.'}]
)
print(msg.content[0].text)
```


```python
# Multi-turn conversation
messages = [
  {'role': 'user', 'content': 'What is a neural network?'},
  {'role': 'assistant', 'content': 'A neural network is...'},
  {'role': 'user', 'content': 'Can you give an example?'}
]
msg = client.messages.create(model='claude-sonnet-4-6', max_tokens=1024, messages=messages)
```


```python
# System prompt (set persona / task context)
msg = client.messages.create(
  model='claude-sonnet-4-6',
  max_tokens=1024,
  system='You are a data science tutor. Explain things simply with short code examples.',
  messages=[{'role': 'user', 'content': 'What is overfitting?'}]
)
```


```python
# Streaming response
with client.messages.stream(
  model='claude-sonnet-4-6',
  max_tokens=1024,
  messages=[{'role': 'user', 'content': 'Write a poem.'}]
) as stream:
  for text in stream.text_stream:
    print(text, end='', flush=True)
```



## Data Science


### NumPy (numpy)

```python
import numpy as np
a = np.array([1, 2, 3])                          # create 1D array
a = np.array([[1, 2], [3, 4]])                   # create 2D array
np.zeros((3, 4))                                 # 3x4 array of zeros
np.ones((3, 4))                                  # 3x4 array of ones
np.arange(0, 10, 2)                              # array [0, 2, 4, 6, 8]
np.linspace(0, 1, 5)                             # 5 evenly spaced values from 0 to 1
a.shape                                          # dimensions tuple, e.g. (3, 4)
a.dtype                                          # data type of elements
a.reshape(2, 3)                                  # reshape (total elements must match)
a.T                                              # transpose
a.flatten()                                      # collapse to 1D
a[1, 2]                                          # element at row 1, col 2
a[0:2, 1:]                                       # slice rows 0-1, cols 1+
a[a > 3]                                         # boolean indexing
np.where(a > 3, a, 0)                            # conditional: a if a>3, else 0
np.concatenate([a, b], axis=0)                   # stack arrays vertically
np.concatenate([a, b], axis=1)                   # stack arrays horizontally
np.vstack([a, b]); np.hstack([a, b])             # vertical / horizontal stack
a + b; a * b                                     # element-wise add / multiply
np.dot(a, b); a @ b                              # dot product / matrix multiply
np.sum(a); np.sum(a, axis=0)                     # sum all / sum along axis
np.mean(a); np.std(a); np.var(a)                 # mean, std deviation, variance
np.min(a); np.max(a)                             # min, max
np.argmin(a); np.argmax(a)                       # index of min / max
np.sort(a); np.argsort(a)                        # sorted array; sort indices
np.unique(a)                                     # unique values
np.random.seed(42)                               # set seed for reproducibility
np.random.rand(3, 4)                             # uniform random [0, 1) array
np.random.randn(3, 4)                            # standard normal random array
np.random.randint(0, 10, (3, 4))                 # random integers in [0, 10)
```


### Pandas (pandas)

```python
import pandas as pd
```


```python
# Series
s = pd.Series([1, 2, 3], index=['a', 'b', 'c']) # create Series with index
s['a']                                           # access by label
s[0]                                             # access by integer position
```


```python
# DataFrame creation
df = pd.DataFrame({'col1': [1, 2], 'col2': [3, 4]})   # from dictionary
df = pd.read_csv('file.csv')                     # read from CSV
df = pd.read_csv('file.csv', index_col=0)        # first column as index
df = pd.read_excel('file.xlsx', sheet_name='Sheet1')   # read from Excel
df = pd.read_json('file.json')                   # read from JSON
df.to_csv('file.csv', index=False)               # write to CSV
df.to_excel('file.xlsx', index=False)            # write to Excel
```


```python
# Inspection
df.head(5); df.tail(5)                           # first / last 5 rows
df.shape                                         # (rows, columns)
df.info()                                        # column types and null counts
df.describe()                                    # summary statistics for numeric columns
df.columns                                       # column names
df.dtypes                                        # data type per column
df.isnull().sum()                                # count nulls per column
```


```python
# Selection
df['col']                                        # select column (returns Series)
df[['col1', 'col2']]                             # select multiple columns (returns DataFrame)
df.loc[2]                                        # row by label
df.loc[2, 'col']                                 # value at row label and column name
df.iloc[2]                                       # row by integer position
df.iloc[2, 3]                                    # value at integer row/col position
df.iloc[0:3, 1:4]                                # slice by integer position
df[df['col'] > 3]                                # filter rows by condition
df[(df['col1'] > 3) & (df['col2'] == 'x')]       # filter with multiple conditions
df.query('col1 > 3 and col2 == "x"')             # filter using query string
```


```python
# Modification
df['new'] = df['col1'] + df['col2']              # add computed column
df.drop('col', axis=1, inplace=True)             # drop column in place
df.drop(2, axis=0)                               # drop row by label
df.rename(columns={'old': 'new'}, inplace=True)  # rename column
df['col'] = df['col'].astype(float)              # change column type
df.fillna(0)                                     # fill nulls with value
df.fillna(method='ffill')                        # forward-fill nulls
df.dropna()                                      # drop rows with any null
df.dropna(subset=['col'])                        # drop rows where specific col is null
df.replace({'a': 1, 'b': 2})                     # replace values
df.apply(my_function)                            # apply function to each column
df['col'].apply(my_function)                     # apply function to each value in column
df['col'].map({'a': 1, 'b': 2})                  # map values via dictionary
```


```python
# Aggregation and grouping
df.groupby('col').mean()                         # group by column, compute mean
df.groupby('col').agg({'a': 'sum', 'b': 'mean'}) # different aggregations per column
df.groupby(['col1', 'col2']).size()              # count rows per group
df.pivot_table(values='v', index='r', columns='c', aggfunc='mean')   # pivot table
df.sort_values('col')                            # sort ascending
df.sort_values('col', ascending=False)           # sort descending
df.sort_values(['col1', 'col2'])                 # sort by multiple columns
df['col'].value_counts()                         # frequency count of each unique value
```


```python
# Merging and joining
pd.concat([df1, df2])                            # stack DataFrames vertically
pd.concat([df1, df2], axis=1)                    # stack DataFrames horizontally
pd.merge(df1, df2, on='key')                     # inner join on key column
pd.merge(df1, df2, on='key', how='left')         # left join
df1.join(df2, how='inner')                       # join on index
```


### Matplotlib (matplotlib)

```python
import matplotlib.pyplot as plt
plt.plot(x, y)                                   # line plot
plt.scatter(x, y)                                # scatter plot
plt.bar(x, height)                               # bar chart
plt.hist(data, bins=20)                          # histogram
plt.boxplot(data)                                # box plot
plt.xlabel('X'); plt.ylabel('Y')                 # axis labels
plt.title('Title')                               # chart title
plt.legend(['series1', 'series2'])               # legend
plt.xlim(0, 10); plt.ylim(0, 10)                 # axis limits
plt.grid(True)                                   # show grid
plt.tight_layout()                               # auto-adjust spacing
plt.savefig('plot.png', dpi=150)                 # save to file
plt.show()                                       # display plot
```


```python
# Subplots
fig, axes = plt.subplots(2, 3, figsize=(12, 8))  # 2x3 grid of subplots
axes[0, 1].plot(x, y)                            # plot in specific subplot
fig.suptitle('Overall Title')                    # title for entire figure
```


### Seaborn (seaborn)

```python
import seaborn as sns
sns.set_theme()                                  # apply default theme
sns.histplot(df['col'], kde=True)                # histogram with density curve
sns.boxplot(x='category', y='value', data=df)   # box plot
sns.scatterplot(x='col1', y='col2', hue='cat', data=df)  # scatter with color grouping
sns.heatmap(df.corr(), annot=True, cmap='coolwarm')       # correlation heatmap
sns.pairplot(df)                                 # pairwise scatter plots for all columns
sns.lineplot(x='col1', y='col2', data=df)        # line plot
```


### Scikit-learn (sklearn)

```python
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.preprocessing import StandardScaler, LabelEncoder
from sklearn.linear_model import LinearRegression, LogisticRegression
from sklearn.ensemble import RandomForestClassifier, RandomForestRegressor
from sklearn.metrics import accuracy_score, mean_squared_error, classification_report
```


```python
# Train/test split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
```


```python
# Preprocessing
scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)          # fit on training data and transform
X_test = scaler.transform(X_test)                # transform test using training fit (no re-fit)
le = LabelEncoder()
y = le.fit_transform(y)                          # encode string labels to integers
```


```python
# Training and prediction
model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X_train, y_train)                      # train
y_pred = model.predict(X_test)                   # class predictions
y_prob = model.predict_proba(X_test)             # class probabilities
```


```python
# Evaluation - classification
accuracy_score(y_test, y_pred)                   # overall accuracy
print(classification_report(y_test, y_pred))     # precision, recall, F1 per class
```


```python
# Evaluation - regression
mean_squared_error(y_test, y_pred)               # MSE
mean_squared_error(y_test, y_pred, squared=False) # RMSE
model.score(X_test, y_test)                      # R² score
```


```python
# Feature importance (tree-based models)
model.feature_importances_                       # array of importance scores per feature
```


```python
# Cross-validation
scores = cross_val_score(model, X, y, cv=5)      # 5-fold CV accuracy scores
scores.mean(); scores.std()                      # mean and spread of CV scores
```



## Python 2 -> 3 Migration


### Python 3:                    Python 2.x

```python
print(x)                    print x
s = input(x)                s = raw_input(x)
except Error as e:          except Error, e:
raise Error(message)        raise Error, message
```


Packages: Queue and Tkinter are now queue and tkinter
```python
import urllib                import urllib.request, urllib.parse, urllib.error
import urllib2              import urllib.request, urllib.error
```



## Importing


import foo                  # import module foo from current folder

sys.path.append(some_other_folder)
import foo                  # import module foo from paths including inserted path

# note: extended paths continue to apply to imported modules - if bar foo is imported
# in a module that extends the current path, then foo could further import bar.foo
# without having to include its own path extension command - however, there is
# no harm in importing the same path twice, so it might be best to do so anyway, like this:
main_path = os.path.dirname(os.path.dirname(os.path.realpath(__file__)))
```python
 # get path one level up from current file
```

sys.path.append(os.path.join(main_path, 'bar'))
import bar.baz


## Walrus Operator


Assignment-expression operator: assigns a value to a variable and yields value for expression

### Examples

```python
if (y := f(x)) is not None:      ...        # same as:     y = f(x); if y is not None: ...
while chunk := file.read(1024): ...         # combines assignment and loop test
[y := f(x), y**2, y**3]                     # avoids multiple calls to f(x) in list generation
w = [y for x in z if (y := f(x)) > 1)]      # list of *processed* values that fulfill a condition
if any((i := int(s)) > 0 for s in lines):   # i = first instance of processed value that fulfills condition
if all((i := int(s)) > 0 for s in lines):   # if not true, i = first instance that *fails* condition
```



## Miscellaneous Code


### Running script only if directly executed

```python
if __name__ == '__main__': ...
```


### Single-instance check

```python
def check_running_process(process_name):
  ps = subprocess.Popen("ps -ef | grep " + process_name, shell=True, stdout=subprocess.PIPE)
  output = ps.stdout.read(); ps.stdout.close(); ps.wait()
  return re.findall('(\d+)\D.*ython.*?' + process_name, output.decode('UTF-8'))
```


### Ranges

```python
range(4)           # [0, 1, 2, 3]
range(2, 5)        # [2, 3, 4]
range(0, 10, 2)    # [0, 2, 4, 6, 8]
```


### Loop over range

```python
for x in range(0, 3):
```


### Randomization (random)

```python
random.randint(start, stop)        # randomly selected integer between start and stop (inclusive)
random.choice([a, b, c])           # random choice from a list of objects
```


### Assert

```python
assert (x == 3), 'Error: x != 3'
```


### Exception handling

```python
try: ...
except Exception as error:
  print(str(error))
```


### Command-line parameters

```python
print(str(len(sys.argv)) + ': ' + ', '.join(sys.argv))
```


### Hashing (hashlib)

```python
hash = hashlib.sha1(ciphertext.encode('ascii')).hexdigest()
    # compatible with Javascript hashing... don't use SHA-1 for anything serious though
```


### Graceful exit

```python
sys.exit(0)
```



## Config File


This reads a named file, or by default looks for "(main_script.py).config.txt". It reads the file,
throws away everything after a hash (either full-line or part-line comments), and splits on '='.

This can be called with config{}, which is loaded with default values. It can also be forced to
accept only values for keys that are specified in the dictionary with at least one default, or to
accept any key/value pair. Ints and bools are parsed accordingly.

By default, this code edits the dictionary in place, so if a default dictionary is passed in, it
will be updated. It also returns the dictionary, in case none was passed in.

def read_config(filename = '', config = {}, limit_to_defaults = False):
```python
filename = filename if len(filename) > 0 else os.path.realpath(__file__).replace('.py', '.config.txt')
if not os.path.isfile(filename):
  return
with open(filename, 'r') as f:
  lines = f.read().splitlines()
  for line in lines:
    line = (line[:line.find('#')] if line.find('#') > -1 else line).strip()
    parameters = line.split('=')
    if len(parameters) != 2:
      continue
    key, value = (p.strip() for p in parameters)
    if limit_to_defaults and key not in config:
      pass
    value = True if isinstance(value, str) and value.lower() == 'true' else value
    value = False if isinstance(value, str) and value.lower() == 'false' else value
    value = int(value) if isinstance(value, str) and value.isnumeric() else value
    config[key] = value
return config
```



## External Code Examples


argparse_example.py   # argparse example
download_from_url.py  # file download / page-scraping example, via urllib2
getch.py              # getch example #1
keypress.py           # getch example #2
maze.py               # maze creation algorithm
menubar.py            # menu bar application (RUMPS)
mqtt_pub.py           # MQTT publisher example
mqtt_sub.py           # MQTT subscriber example
pdf_converter.py      # PDF text extraction
pipe_client.py        # named pipe client example
pipe_server.py        # named pipe server example
sqlite_example.py     # SQLite example
socket_client.py      # socket client example
socket_server.py      # socket server example
tkinter_first.py      # tkinter "Hello, World!"-ish example
tkinter_multi.py      # tkinter multithreading example
tkinter_table.py      # tkinter table
twilio_example.py     # Twilio example
vignere.py            # Very simple symmetric-key encryption


## Pip


### Install module in user space

```python
pip install --user module_name
```


### View list of installed modules

```python
pip freeze
```


### Check versions of a particular module

```python
pip freeze | grep module_name
```


### Upgrade module

```python
pip install --upgrade --user module_name
```



## VirtualEnv


Creating a new environment (places files in path_to_environment_folder):
```python
python3 -m venv path_to_environment_folder
```


Creating a new environment with a specific Python interpreter:
```python
virtualenv -p /usr/bin/python2.7 path_to_environment_folder
```


### Activating environment

```python
source path_to_environment_folder/bin/activate (macOS/Linux)
(folder)\Scripts\activate.bat (Windows)
```


### Deactivating environment

```python
deactivate
```


Running a script from specified environment: Just identify it in hashbang.
```python
Example #1, from a base folder:
  virtualenv -p /usr/bin/python2.7 ./env
  Place code in same folder, and reference interpreter as:
  #!./env/bin/python2.7
Example #2, from a base folder:
  virtualenv -p /usr/bin/python2.7 ./env
  Place code in Code folder, and reference interpreter as:
  #!../env/bin/python2.7
```



## PyEnv


### Installing pyenv

```python
brew install pyenv
```

### Add the following to the end of .bash_profile

```python
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
```


Checking the current version of Python associated with shell python command:
```python
python -V -V
```


### Checking installed versions

```python
pyenv versions
```


### Setting version of pyenv

```python
pyenv global (version number)
```




## Miscellaneous Other


### Examining assembly

```python
dis.dis('a = b')                  # generates a list of assembly instructions
```


pyw: Naming a module with a .pyw extension indicates that it shouldn't open a terminal window

### Code profiling

```python
python -m cProfile myfile.py      # return a table showing amount of time in each function
```


### Setup packages

http://the-hitchhikers-guide-to-packaging.readthedocs.io/en/latest/quickstart.html

=
