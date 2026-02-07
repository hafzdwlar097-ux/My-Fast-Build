from kivy.app import App
from kivy.uix.floatlayout import FloatLayout
from kivy.uix.label import Label
from kivy.uix.button import Button
from kivy.graphics import Color, Rectangle

class TasbehApp(App):
    def build(self):
        layout = FloatLayout()
        with layout.canvas.before:
            Color(0, 0, 0)
            Rectangle(size=(800, 600))
        self.count = 0
        self.label = Label(
            text=str(self.count),
            font_size=50,
            color=(1, 1, 1, 1),
            pos_hint={'center_x': 0.5, 'center_y': 0.7},
            size_hint=(0.2, 0.1)
        )
        layout.add_widget(self.label)
        button = Button(
            text='سبح',
            font_size=30,
            background_color=(0, 1, 0, 1),
            pos_hint={'center_x': 0.5, 'center_y': 0.5},
            size_hint=(0.4, 0.2)
        )
        button.bind(on_press=self.increment)
        layout.add_widget(button)
        reset_button = Button(
            text='تصفير',
            font_size=20,
            background_color=(1, 0, 0, 1),
            pos_hint={'center_x': 0.5, 'center_y': 0.3},
            size_hint=(0.2, 0.1)
        )
        reset_button.bind(on_press=self.reset)
        layout.add_widget(reset_button)
        return layout

    def increment(self, instance):
        self.count += 1
        self.label.text = str(self.count)

    def reset(self, instance):
        self.count = 0
        self.label.text = str(self.count)

if __name__ == '__main__':
    TasbehApp().run()