```python
from kivy.app import App
from kivy.uix.label import Label

class MakeApp(App):
    def build(self):
        return Label(text='Make App')

if __name__ == '__main__':
    MakeApp().run()
```