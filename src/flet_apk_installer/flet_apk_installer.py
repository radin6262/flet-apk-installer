from typing import Optional, Callable
import time
import flet as ft


@ft.control("FletApkInstaller")
class FletApkInstaller(ft.LayoutControl):
    path: str = ""
    install_request: str = ""

    on_debug: Optional[Callable] = None
    on_success: Optional[Callable] = None
    on_error: Optional[Callable] = None

    def __init__(
        self,
        path: Optional[str] = None,
        on_debug: Optional[Callable] = None,
        on_success: Optional[Callable] = None,
        on_error: Optional[Callable] = None,
        **kwargs,
    ):
        super().__init__(**kwargs)

        if path is not None:
            self.path = path

        self.on_debug = on_debug
        self.on_success = on_success
        self.on_error = on_error

    def install(self):
        self.install_request = str(time.time_ns())
        self.update()