$PBExportHeader$w_cartera.srw
forward
global type w_cartera from w_ventana_padre_aplicaciones
end type
end forward

global type w_cartera from w_ventana_padre_aplicaciones
integer width = 2930
integer height = 1932
string title = "Modulo de cartera"
string menuname = "mi_cartera"
end type
global w_cartera w_cartera

on w_cartera.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "mi_cartera" then this.MenuID = create mi_cartera
end on

on w_cartera.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;SELECT utigrupos.nacional INTO :nacional FROM utigrupos  
WHERE utigrupos.descripcion = "FINANZAS";

tipo_vista=""

if nacional="S" then
	tipo_vista="Nacional"
	mi_cartera.m_nacionalexportacin.m_ambos.enabled=false
	mi_cartera.m_nacionalexportacin.m_exportacin.enabled=false
	mi_cartera.m_nacionalexportacin.m_nacional.enabled=true
	mi_cartera.m_nacionalexportacin.m_nacional.checked=true
end if
if nacional="N" then
	tipo_vista="Exportacion"
	mi_cartera.m_nacionalexportacin.m_ambos.enabled=false
	mi_cartera.m_nacionalexportacin.m_nacional.enabled=false
	mi_cartera.m_nacionalexportacin.m_exportacin.enabled=true
	mi_cartera.m_nacionalexportacin.m_exportacin.checked=true
end if
if nacional="A" then
	tipo_vista="Ambos"
	mi_cartera.m_nacionalexportacin.m_ambos.enabled=true
	mi_cartera.m_nacionalexportacin.m_exportacin.enabled=true
	mi_cartera.m_nacionalexportacin.m_nacional.enabled=True
	mi_cartera.m_nacionalexportacin.m_ambos.checked=true
end if

str_parametros lstr_param
OpenSheetWithParm(w_cartera_arbol,lstr_param, w_cartera, 3,Original!)
end event

