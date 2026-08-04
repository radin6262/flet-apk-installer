from typing import Optional
import time
import flet as ft


@ft.control("FletApkInstaller")
class FletApkInstaller(ft.LayoutControl):

    def __init__(
        self,
        path: Optional[str] = None,
        **kwargs
    ):
        super().__init__(**kwargs)

        if path:
            self.path = path

    @property
    def path(self):
        return self._get_attr("path", "") or ""

    @path.setter
    def path(self, value):
        self._set_attr("path", value)

    def install(self):
        self._set_attr("install_request", str(time.time()))
        self.update()