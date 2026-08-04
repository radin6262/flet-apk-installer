import time
import flet as ft
from typing import Optional


@ft.control("FletApkInstaller")
class FletApkInstaller(ft.LayoutControl):
    path: str = ""
    install_request: str = ""

    on_debug: Optional[ft.EventHandler] = None
    on_success: Optional[ft.EventHandler] = None
    on_error: Optional[ft.EventHandler] = None

    def install(self):
        self.install_request = str(time.time_ns())
        self.update()