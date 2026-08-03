from typing import Optional
import flet as ft


@ft.control("FletApkInstaller")
class FletApkInstaller(ft.LayoutControl):
    """
    Flet control for installing APK files on Android.
    """

    def __init__(
        self,
        path: Optional[str] = None,
        **kwargs
    ):
        super().__init__(**kwargs)

        if path is not None:
            self.path = path

    @property
    def path(self) -> str:
        return self._get_attr("path", "") or ""

    @path.setter
    def path(self, value: str):
        self._set_attr("path", value)

    def install(self):
        self._dispatch_event("install", {})