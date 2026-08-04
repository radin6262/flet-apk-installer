from typing import Optional, Callable
import time
import flet as ft


@ft.control("FletApkInstaller")
class FletApkInstaller(ft.LayoutControl):
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

    @property
    def path(self) -> str:
        return self._get_attr("path", "") or ""

    @path.setter
    def path(self, value: str):
        self._set_attr("path", value)

    def install(self):
        # Generate a unique request ID every install
        self._set_attr("install_request", str(time.time_ns()))
        self.update()

    @property
    def on_debug(self):
        return self._get_event_handler("debug")

    @on_debug.setter
    def on_debug(self, handler):
        self._add_event_handler("debug", handler)

    @property
    def on_success(self):
        return self._get_event_handler("success")

    @on_success.setter
    def on_success(self, handler):
        self._add_event_handler("success", handler)

    @property
    def on_error(self):
        return self._get_event_handler("error")

    @on_error.setter
    def on_error(self, handler):
        self._add_event_handler("error", handler)