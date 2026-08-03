from typing import Optional
import flet as ft


@ft.control("FletApkInstaller")
class FletApkInstaller(ft.LayoutControl):

    path: str = ft.string_attr("path")

    def __init__(
        self,
        path: Optional[str] = None,
        **kwargs
    ):
        super().__init__(**kwargs)

        if path:
            self.path = path

    def install(self):
        self._dispatch_event("install", {})