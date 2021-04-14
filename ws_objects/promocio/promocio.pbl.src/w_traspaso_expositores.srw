$PBExportHeader$w_traspaso_expositores.srw
forward
global type w_traspaso_expositores from w_int_con_empresa
end type
type st_conpromped2 from statictext within w_traspaso_expositores
end type
type uo_cliente from u_em_campo_2 within w_traspaso_expositores
end type
type pb_1 from upb_salir within w_traspaso_expositores
end type
type pb_imprimir from upb_imprimir within w_traspaso_expositores
end type
type dw_listado from datawindow within w_traspaso_expositores
end type
type uo_manejo from u_manejo_datawindow within w_traspaso_expositores
end type
type ddlb_1 from dropdownlistbox within w_traspaso_expositores
end type
type dw_detalle from u_datawindow_consultas within w_traspaso_expositores
end type
type dw_detalle2 from u_datawindow_consultas within w_traspaso_expositores
end type
type cb_continuar from u_boton within w_traspaso_expositores
end type
type st_des from statictext within w_traspaso_expositores
end type
type ddlb_2 from dropdownlistbox within w_traspaso_expositores
end type
type uo_cliente2 from u_em_campo_2 within w_traspaso_expositores
end type
type st_1 from statictext within w_traspaso_expositores
end type
type st_2 from statictext within w_traspaso_expositores
end type
type em_fecha from u_em_campo within w_traspaso_expositores
end type
end forward

global type w_traspaso_expositores from w_int_con_empresa
integer width = 2912
integer height = 1572
st_conpromped2 st_conpromped2
uo_cliente uo_cliente
pb_1 pb_1
pb_imprimir pb_imprimir
dw_listado dw_listado
uo_manejo uo_manejo
ddlb_1 ddlb_1
dw_detalle dw_detalle
dw_detalle2 dw_detalle2
cb_continuar cb_continuar
st_des st_des
ddlb_2 ddlb_2
uo_cliente2 uo_cliente2
st_1 st_1
st_2 st_2
em_fecha em_fecha
end type
global w_traspaso_expositores w_traspaso_expositores

type variables
String situ
end variables

forward prototypes
public subroutine f_detalle (integer reg)
public function boolean f_calculo_albaran (str_promalb alb)
public function boolean f_pase_detalle (str_promlinalb lin, decimal xanyo, decimal xalbaran, decimal xlinea)
public subroutine f_procesar (integer reg)
end prototypes

public subroutine f_detalle (integer reg);IF reg = 0 Then Return
IF IsNUll(reg) Then Return
String serie
IF dw_detalle.RowCount() = 0 Then Return
serie = dw_detalle.GetItemString(reg,"numserie")
dw_detalle2.Retrieve(codigo_empresa,serie)

end subroutine

public function boolean f_calculo_albaran (str_promalb alb);Dec  var_peso_panel,var_coste_manipulacion,var_coste_panel,var_venta_panel
			
   Select Sum(peso_material*cantidad),sum(coste_material*cantidad),sum(venta_material*cantidad) ,
  	       Sum(peso_panel*cantidad)  , sum(coste_panel * cantidad),
			 sum(venta_panel*cantidad) , sum(coste_manipulacion * cantidad) 
	Into :alb.peso_material,:alb.coste_material, :alb.venta_material,
 	     :var_peso_panel,   :var_coste_panel,    :var_venta_panel,
  		  :var_coste_manipulacion
	From   promlinalb
   WHERE  promlinalb.empresa = :codigo_empresa 
	AND    promlinalb.anyo    = :alb.anyo 
	AND    promlinalb.albaran  = :alb.albaran;

			IF IsNull(alb.peso_material)   Then alb.peso_material   = 0
			IF IsNull(var_coste_panel)     Then var_coste_panel     = 0
			IF IsNull(alb.venta_material)  Then alb.venta_material  = 0
			IF IsNull(var_peso_panel)      Then var_peso_panel      = 0
			IF IsNull(alb.coste_material)  Then alb.coste_material  = 0
			IF IsNull(var_venta_panel)     Then var_venta_panel     = 0
			IF IsNull(var_coste_manipulacion)     Then var_coste_manipulacion  = 0
			


	  UPDATE promalb  
     SET peso_material  = :alb.peso_material,   
         coste_material = :alb.coste_material,   
         venta_material = :alb.venta_material,
	      peso_paneles  = :var_peso_panel,   
         coste_paneles = :var_coste_panel,   
         venta_paneles = :var_venta_panel,
			coste_manipulacion = :var_coste_manipulacion,
			promalb.peso_total  = :alb.peso_material + :var_peso_panel  + promalb.peso_expositor ,
         promalb.coste_total = :alb.coste_material+ :var_coste_panel + promalb.coste_expositor   + :var_coste_manipulacion,   
         promalb.venta_total = :alb.venta_material+ :var_venta_panel + promalb.venta_expositor   + :var_coste_manipulacion
   WHERE promalb.empresa  = :codigo_empresa 
	AND   promalb.anyo     = :alb.anyo
	AND   promalb.albaran   = :alb.albaran;
	IF SQLCA.SQLCODE <> 0 Then Return FALSE
	Return TRUE





end function

public function boolean f_pase_detalle (str_promlinalb lin, decimal xanyo, decimal xalbaran, decimal xlinea);DataStore dd
String sel
Dec r,r1
str_promlindetallalb l


sel = "  SELECT *   FROM promlindetallalb  where empresa = '"+ codigo_empresa + "'" +&
													"   and   anyo = " + String(xanyo,"####") + &
													"   and   albaran = " + String(xalbaran,"##########") + &
													"   and   linea = " + String(xlinea,"###############") 	


//dd  = f_cargar_cursor2(sel)
f_cargar_cursor_nuevo(sel, dd)
r1 = dd.rowcount()
For r = 1 to r1
l.empresa  = lin.empresa 
l.anyo     = lin.anyo
l.albaran  = lin.albaran
l.linea    = lin.linea
l.orden    = r   
l.panel    = lin.panel
l.articulo =  dd.GetItemString(r,"articulo")
l.calidad  = dd.GetItemString(r,"calidad")
l.montajeartcal  = dd.GetItemString(r,"montajeartcal")
l.piezas=  dd.GetItemNumber(r,"piezas")
l.usuario= lin.usuario
l.usuario_pedido= lin.usuario_pedido
SetNull(l.observaciones)
l.peso= dd.GetItemNumber(r,"peso")
l.coste= dd.GetItemNumber(r,"coste")
l.venta= dd.GetItemNumber(r,"venta")
l.pais= lin.pais
l.cliente= lin.cliente
l.tipo= lin.tipo
l.reposicion= "N"
l.situacion= "S"
l.f_albaran= lin.f_albaran
l.f_entrega= lin.f_entrega
l.agente1= lin.agente1
l.agente2= lin.agente2
l.agente3= lin.agente3
l.tipo_expositor= lin.tipo_expositor
l.expositor= lin.expositor
l.f_entrega_real= lin.f_entrega_real
SetNull(l.anyo_pedido)
SetNull(l.pedido)
SetNull(l.linea_pedido)
SetNull(l.orden_pedido)
l.activo= "S"
SetNull(l.f_reposicion)
SetNull(l.f_retirada)
SetNUll(l.f_pedido)
IF Not f_insert_promlindetallalb(l)Then Return FALSE
Next
destroy dd
Return TRUE
end function

public subroutine f_procesar (integer reg);//---------------------------------------------------------------------
Str_promalb alb
Str_promlinalb lin
string tipo_cli
Int bien,r,r1
Dec xanyo,xlinea,xalbaran
bien = 0
tipo_cli = "N"
if ddlb_2.text="Si" then tipo_cli="S"

   SELECT   venclientes.zona,venclientes.serie, venclientes.agente1,   
            venclientes.agente2,
            venclientes.transportista,   
            venclientes.forma_envio,
				venclientes.tipo_portes,   
            venclientes.cod_entrega, venclientes.periodo_fac,   
            venclientes.domiciliacion,
            venclientes.envio,           venclientes.correspondencia,   
            venclientes.empresa,         venclientes.codigo  
       INTO :alb.zona, :alb.serie,
		 		:alb.agente1, :alb.agente2,
            :alb.transportista,:alb.forma_envio,   
            :alb.tipo_portes,:alb.cod_entrega,:alb.periodo_fac,
            :alb.domiciliacion,   
            :alb.envio, :alb.correspondencia,:alb.empresa,   
            :alb.cliente 
          FROM  venclientes  
          WHERE venclientes.empresa = :codigo_empresa 
			 AND   venclientes.codigo  = :alb.cliente;


          Select  genter.idioma,genter.pais
          Into    :alb.idioma,:alb.pais
          From    genter
          Where   genter.empresa = :codigo_empresa
          And     genter.tipoter = 'C'
          And     genter.codigo  = :alb.cliente;
			 
			 
			 

alb.empresa = codigo_empresa
alb.anyo    = Year(Today())
Select max(promalb.albaran) Into :alb.albaran From promalb
Where  promalb.empresa   =  :codigo_empresa
And    promalb.anyo      =  :alb.anyo;
If IsNull(alb.albaran) Then alb.albaran = 0
alb.albaran  = alb.albaran + 1
alb.falbaran = DateTime(Today(),Now())
alb.fentrega = DateTime(Date(em_fecha.text))
alb.falta    = DateTime(Today(),Now())
alb.cliente  = uo_cliente2.em_codigo.text
SetNull(alb.flistado)
SetNull(alb.observaciones)
alb.usuario = nombre_usuario
alb.usuario_pedido = nombre_usuario
alb.veces= 0
alb.tipo_expositor = dw_detalle.GetItemString(reg,"tipo_expositor")
SetNUll(alb.expositor)
alb.tipo       = "2"
alb.reposicion = "N"
alb.situacion  = "S"
SetNull(alb.control_libre)   
alb.f_entrega_real  = DateTime(Date(em_fecha.text))
alb.clase_panel = f_clase_panel_promparam(codigo_empresa)
alb.numserie    = dw_detalle.GetItemString(reg,"numserie")
alb.exp_cargado = "S"
alb.tipo_cliente = tipo_cli

		 alb.peso_expositor  = f_peso_promexpositores(codigo_empresa,alb.tipo_expositor)
 		 alb.coste_expositor = f_coste_promexpositores(codigo_empresa,alb.tipo_expositor)
  		 alb.venta_expositor = f_pventa_promexpositores(codigo_empresa,alb.tipo_expositor)
		 IF IsNull(alb.peso_expositor)  Then  alb.peso_expositor  = 0
		 IF IsNull(alb.coste_expositor) Then  alb.coste_expositor = 0
		 IF IsNull(alb.venta_expositor) Then  alb.venta_expositor = 0
		 alb.peso_total  = alb.peso_expositor 
		 alb.coste_total = alb.coste_expositor
		 alb.venta_total = alb.venta_expositor

IF Not f_insert_promalb(alb)    Then  bien  =  1

DataStore dw
String   sel
sel = "Select * from promlinalb Where empresa  = '" + codigo_empresa +"'" + &
                             " And   numserie = '" + alb.numserie + "'" + &
									  " And   activo   =  'S' "
//dw = f_cargar_cursor2(sel)
f_cargar_cursor_nuevo(sel, dw)
r1 = dw.RowCount()
For r = 1 To r1
	xanyo = dw.GetItemNumber(r,"anyo")
	xalbaran = dw.GetItemNumber(r,"albaran")
   xlinea = dw.GetItemNumber(r,"linea")
	  SELECT promlinalb.panel,          promlinalb.cantidad,promlinalb.peso_panel,   
	         promlinalb.coste_panel,    promlinalb.venta_panel,
				promlinalb.peso_material,  promlinalb.coste_material,   
         	promlinalb.venta_material, promlinalb.clase_panel,   
   	      promlinalb.coste_manipulacion  
    INTO :lin.panel, :lin.cantidad,  :lin.peso_panel,   :lin.coste_panel,   
         :lin.venta_panel,   :lin.peso_material,   :lin.coste_material,   
         :lin.venta_material,   :lin.clase_panel,:lin.coste_manipulacion  
    FROM  promlinalb 
	 Where promlinalb.empresa  = :codigo_empresa
	 And   promlinalb.anyo     = :xanyo
	 And   promlinalb.albaran  = :xalbaran
	 ANd   promlinalb.linea    = :xlinea;

lin.empresa  = alb.empresa
lin.anyo     = alb.anyo
lin.albaran  = alb.albaran
lin.linea    = r
lin.cliente  = alb.cliente
lin.pais     = alb.pais
lin.tipo   = alb.tipo
lin.reposicion= "N"
lin.usuario = alb.usuario
lin.usuario_pedido= alb.usuario_pedido
lin.situacion= alb.situacion
SetNull(lin.control_libre)
lin.f_albaran= alb.falbaran
lin.f_entrega= alb.fentrega
lin.agente1= alb.agente1
lin.agente2= alb.agente2
lin.agente3= alb.agente3
lin.tipo_expositor= alb.tipo_expositor
lin.expositor= alb.expositor
lin.f_entrega_real= alb.f_entrega_real
SetNull(lin.anyo_pedido)
SetNull(lin.pedido)
SetNUll(lin.linea_pedido)
lin.activo= "S"
SetNull(lin.f_reposicion)
SetNull(lin.f_retirada)
SetNUll(lin.f_pedido)
lin.numserie= alb.numserie
lin.tipo_cliente  = alb.tipo_cliente
IF Not f_insert_promlinalb(lin) Then bien = 1
  lin.f_retirada = DateTime(Today(),Now())
  UPDATE promlinalb  
     SET f_retirada = :lin.f_retirada,   
         activo = "N"  
   WHERE promlinalb.empresa  = :codigo_empresa
	AND   promlinalb.anyo     = :xanyo 
	AND   promlinalb.albaran  = :xalbaran 
	AND   promlinalb.linea    = :xlinea;
	IF sqlca.sqlcode <> 0 Then bien = 1
	
	UPDATE promlindetallalb  
     SET f_retirada = :lin.f_retirada,   
         activo = "N"  
   WHERE promlindetallalb.empresa  = :codigo_empresa
	AND   promlindetallalb.anyo     = :xanyo 
	AND   promlindetallalb.albaran  = :xalbaran 
	AND   promlindetallalb.linea    = :xlinea;
	IF sqlca.sqlcode <> 0 Then bien = 1
	IF Not f_pase_detalle(lin,xanyo,xalbaran,xlinea) Then bien = 1
f_contador_procesos(r,r1)
Next
IF Not f_calculo_albaran(alb)   Then  bien  =  1

///////////////////////////////////////////////////////////////////
// Comprueba el nº de serie y lo asigna al nuevo cliente
    
if Trim(alb.numserie)<>"" or  not isnull(alb.numserie) then
	 String var_nombre,var_pais,var_provincia,var_codpostal
	 String var_domicilio,var_poblacion
	 SELECT genter.razon,genter.pais,genter.provincia,genter.cod_postal,   
		 	  genter.domicilio,genter.localidad  
		INTO :var_nombre,:var_pais,:var_provincia,:var_codpostal,   
		 	  :var_domicilio,:var_poblacion  
	   FROM genter  
	  WHERE genter.empresa = :codigo_empresa  
	    AND genter.tipoter = 'C' 
		 AND genter.codigo  = :alb.cliente ;
		
	 Update promseries
		 Set cliente    = :alb.cliente,
			  nombre     = :var_nombre,
			  domicilio  = :var_domicilio,
			  codpostal  = :var_codpostal,
			  provincia  = :var_provincia,
		  	  pais       = :var_pais,
			  poblacion  = :var_poblacion
 	  Where empresa    = :codigo_empresa
	    And codigo     = :alb.numserie;
		  IF sqlca.sqlcode <> 0 Then bien = 1
End if
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////

IF bien = 0 Then
	Commit;
Else
	RollBack;
	f_mensaje("Error en base de datos","El proceso no se contabiliza")
END IF
cb_continuar.TriggerEvent(Clicked!)
end subroutine

on w_traspaso_expositores.create
int iCurrent
call super::create
this.st_conpromped2=create st_conpromped2
this.uo_cliente=create uo_cliente
this.pb_1=create pb_1
this.pb_imprimir=create pb_imprimir
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.ddlb_1=create ddlb_1
this.dw_detalle=create dw_detalle
this.dw_detalle2=create dw_detalle2
this.cb_continuar=create cb_continuar
this.st_des=create st_des
this.ddlb_2=create ddlb_2
this.uo_cliente2=create uo_cliente2
this.st_1=create st_1
this.st_2=create st_2
this.em_fecha=create em_fecha
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_conpromped2
this.Control[iCurrent+2]=this.uo_cliente
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.uo_manejo
this.Control[iCurrent+7]=this.ddlb_1
this.Control[iCurrent+8]=this.dw_detalle
this.Control[iCurrent+9]=this.dw_detalle2
this.Control[iCurrent+10]=this.cb_continuar
this.Control[iCurrent+11]=this.st_des
this.Control[iCurrent+12]=this.ddlb_2
this.Control[iCurrent+13]=this.uo_cliente2
this.Control[iCurrent+14]=this.st_1
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.em_fecha
end on

on w_traspaso_expositores.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_conpromped2)
destroy(this.uo_cliente)
destroy(this.pb_1)
destroy(this.pb_imprimir)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.ddlb_1)
destroy(this.dw_detalle)
destroy(this.dw_detalle2)
destroy(this.cb_continuar)
destroy(this.st_des)
destroy(this.ddlb_2)
destroy(this.uo_cliente2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_fecha)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Albaranes por Cliente"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
dw_detalle2.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
ddlb_1.text ="Si" 
ddlb_2.text ="Si" 
Situ = "T"
em_fecha.text = String(Today())
f_activar_campo(uo_cliente.em_campo)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_detalle)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_detalle)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_detalle)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_detalle)
end event

event activate;call super::activate;w_traspaso_expositores = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_traspaso_expositores
integer taborder = 60
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_traspaso_expositores
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_cliente.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_traspaso_expositores
integer x = 5
integer y = 8
integer width = 2505
integer height = 104
end type

type st_conpromped2 from statictext within w_traspaso_expositores
integer x = 14
integer y = 164
integer width = 233
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_cliente from u_em_campo_2 within w_traspaso_expositores
integer x = 475
integer y = 140
integer width = 1106
integer height = 88
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;IF ddlb_1.text = "Si" then
	ue_titulo = "Selección de Clientes"
	ue_datawindow ="dw_ayuda_clientes"
	ue_filtro = ""
Else
	ue_titulo = "Selección de no cliente"
	ue_datawindow ="dw_ayuda_vencliproforma"
	ue_filtro = ""
End if
end event

event modificado;call super::modificado;if ddlb_1.text = "Si" then
	   uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
	else
      uo_cliente.em_campo.text=f_nombre_vencliproforma(codigo_empresa,uo_cliente.em_codigo.text)		
End if

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 



end event

type pb_1 from upb_salir within w_traspaso_expositores
integer x = 2670
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_imprimir from upb_imprimir within w_traspaso_expositores
integer x = 2693
integer y = 216
integer width = 101
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;string tipo_cli
tipo_cli = "N"
if ddlb_1.text="Si" then tipo_cli="S"
dw_listado.Retrieve(codigo_empresa,tipo_cli,uo_cliente.em_codigo.text)
f_imprimir_datawindow(dw_listado)
end event

type dw_listado from datawindow within w_traspaso_expositores
boolean visible = false
integer width = 352
integer height = 136
integer taborder = 80
boolean bringtotop = true
string dataobject = "report_traspaso_expositores"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_traspaso_expositores
integer x = 2213
integer y = 168
end type

event valores;call super::valores;dw_data=dw_detalle
f_activar_campo(uo_cliente.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type ddlb_1 from dropdownlistbox within w_traspaso_expositores
integer x = 261
integer y = 140
integer width = 210
integer height = 244
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33551093
boolean vscrollbar = true
string item[] = {"Si","No"}
borderstyle borderstyle = stylelowered!
end type

type dw_detalle from u_datawindow_consultas within w_traspaso_expositores
integer y = 344
integer width = 1147
integer height = 976
integer taborder = 0
string dataobject = "dw_con_expositores_act_cliente"
borderstyle borderstyle = styleraised!
end type

event rowfocuschanged;call super::rowfocuschanged;f_detalle(currentrow)
end event

event retrieveend;call super::retrieveend;IF rowcount <> 0 AND Not IsNull(rowcount) Then f_detalle(1)

end event

event doubleclicked;call super::doubleclicked;if row=0 then return
IF MessageBox("Proceso de Traspaso","¿Desea Traspasar el expositor?",Question!,YesNo!) = 1 Then
	f_procesar(row)
END IF
end event

type dw_detalle2 from u_datawindow_consultas within w_traspaso_expositores
integer x = 1147
integer y = 344
integer width = 1669
integer height = 976
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_con_expositores_act_cliente2"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type cb_continuar from u_boton within w_traspaso_expositores
integer x = 1920
integer y = 236
integer width = 288
integer height = 84
integer taborder = 40
string text = "&Continuar"
end type

event clicked;call super::clicked;string tipo_cli
tipo_cli = "N"
dw_detalle.Reset()
dw_detalle2.Reset()
if ddlb_1.text="Si" then tipo_cli="S"
IF Trim(uo_cliente.em_codigo.text) = "" Then
	f_mensaje("Campo Obligatorio","Introduzca el cliente")
	f_activar_campo(uo_cliente.em_campo)
	Return
END IF
IF Trim(uo_cliente2.em_codigo.text) = "" Then
	f_mensaje("Campo Obligatorio","Introduzca el cliente Destino")
	f_activar_campo(uo_cliente2.em_campo)
	Return
END IF
IF Trim(em_fecha.text) = "" Then
	f_mensaje("Campo Obligatorio","Introduzca la fecha de entrega")
	f_activar_campo(em_fecha)
	Return
END IF

dw_detalle.Retrieve(codigo_empresa,tipo_cli,uo_cliente.em_codigo.text)
end event

type st_des from statictext within w_traspaso_expositores
integer x = 14
integer y = 256
integer width = 247
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Destino:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_2 from dropdownlistbox within w_traspaso_expositores
integer x = 265
integer y = 240
integer width = 210
integer height = 244
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33551093
boolean vscrollbar = true
string item[] = {"Si","No"}
borderstyle borderstyle = stylelowered!
end type

type uo_cliente2 from u_em_campo_2 within w_traspaso_expositores
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 475
integer y = 240
integer width = 1106
integer height = 88
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;if ddlb_2.text = "Si" then
	   uo_cliente2.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente2.em_codigo.text)
	else
      uo_cliente2.em_campo.text=f_nombre_vencliproforma(codigo_empresa,uo_cliente2.em_codigo.text)		
End if

If Trim(uo_cliente2.em_campo.text)="" then
	uo_cliente2.em_campo.text=""
	uo_cliente2.em_codigo.text=""
	Return
end if 



end event

event getfocus;call super::getfocus;IF ddlb_1.text = "Si" then
	ue_titulo = "Selección de Clientes"
	ue_datawindow ="dw_ayuda_clientes"
	ue_filtro = ""
Else
	ue_titulo = "Selección de no cliente"
	ue_datawindow ="dw_ayuda_vencliproforma"
	ue_filtro = ""
End if
end event

on uo_cliente2.destroy
call u_em_campo_2::destroy
end on

type st_1 from statictext within w_traspaso_expositores
integer y = 1348
integer width = 1271
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "(*) Pulsar doble click para traspasar"
boolean focusrectangle = false
end type

type st_2 from statictext within w_traspaso_expositores
integer x = 1609
integer y = 152
integer width = 302
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "F.Entrega"
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_fecha from u_em_campo within w_traspaso_expositores
integer x = 1609
integer y = 236
integer width = 302
integer taborder = 30
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

