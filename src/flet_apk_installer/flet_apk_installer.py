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

        self._on_debug = on_debug
        self._on_success = on_success
        self._on_error = on_error

        if path is not None:
            self.path = path

    @property
    def path(self) -> str:
        return self._get_attr("path", "") or ""

    @path.setter
    def path(self, value: str):
        self._set_attr("path", value)

    def install(self):
        self._set_attr(
            "install_request",
            str(time.time_ns())
        )
        self.update()

    def _handle_event(self, e: ft.Event):
        if e.event == "debug":
            if self._on_debug:
                self._on_debug(e)

        elif e.event == "success":
            if self._on_success:
                self._on_success(e)

        elif e.event == "error":
            if self._on_error:
                self._on_error(e)

        return super()._handle_event(e)