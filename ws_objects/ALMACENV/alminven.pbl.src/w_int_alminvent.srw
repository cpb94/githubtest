$PBExportHeader$w_int_alminvent.srw
$PBExportComments$Introduccion de inventario.
forward
global type w_int_alminvent from w_int_con_empresa
end type
type st_2 from statictext within w_int_alminvent
end type
type em_periodo from u_em_campo within w_int_alminvent
end type
type dw_1 from datawindow within w_int_alminvent
end type
type dw_proceso from datawindow within w_int_alminvent
end type
type cb_salir from u_boton within w_int_alminvent
end type
type cb_grabar from u_boton within w_int_alminvent
end type
type dw_zonas from datawindow within w_int_alminvent
end type
type pb_1 from upb_salir within w_int_alminvent
end type
type cb_insertar from u_boton within w_int_alminvent
end type
type cb_1 from u_boton within w_int_alminvent
end type
type dw_insertar from datawindow within w_int_alminvent
end type
type dw_inv from datawindow within w_int_alminvent
end type
type st_6 from statictext within w_int_alminvent
end type
end forward

global type w_int_alminvent from w_int_con_empresa
integer width = 3227
integer height = 1616
st_2 st_2
em_periodo em_periodo
dw_1 dw_1
dw_proceso dw_proceso
cb_salir cb_salir
cb_grabar cb_grabar
dw_zonas dw_zonas
pb_1 pb_1
cb_insertar cb_insertar
cb_1 cb_1
dw_insertar dw_insertar
dw_inv dw_inv
st_6 st_6
end type
global w_int_alminvent w_int_alminvent

type variables
String modo_insercion,grabado,bloqueado
end variables

forward prototypes
public function boolean f_preinput (string empresa, datetime fecha, string almacen, string zona)
public subroutine f_control_insercion ()
public subroutine f_calculo ()
end prototypes

public function boolean f_preinput (string empresa, datetime fecha, string almacen, string zona);str_alminv   inv
str_almtoma  toma


Integer Registros ,bien,x1
bien = 0
Registros=dw_proceso.Retrieve(empresa,fecha,almacen,zona)
IF registros<>0 THEN
  FOR x1 = 1 To registros
  toma.empresa        = dw_proceso.GetItemString(x1,"empresa")
  toma.almacen        = dw_proceso.GetItemString(x1,"almacen")
  toma.zona           = dw_proceso.GetItemString(x1,"zona")
  toma.fila           = dw_proceso.GetItemNumber(x1,"fila")
  toma.altura         = dw_proceso.GetItemNumber(x1,"altura")
  toma.linea          = dw_proceso.GetItemNumber(x1,"linea")
  toma.articulo       = dw_proceso.GetItemString(x1,"articulo")
  toma.familia        = dw_proceso.GetItemString(x1,"familia")
  toma.formato        = dw_proceso.GetItemString(x1,"formato")
  toma.modelo         = dw_proceso.GetItemString(x1,"modelo")
  toma.calidad        = dw_proceso.GetItemString(x1,"calidad")
  toma.tonochar       = dw_proceso.GetItemString(x1,"tonochar")
  toma.calibre        = dw_proceso.GetItemNumber(x1,"calibre")
  toma.existencias    = dw_proceso.GetItemNumber(x1,"existencias")
  toma.anyo           = dw_proceso.GetItemNumber(x1,"anyo")
  toma.pedido         = dw_proceso.GetItemNumber(x1,"pedido")
  toma.linped         = dw_proceso.GetItemNumber(x1,"linped")
  toma.cliente        = dw_proceso.GetItemString(x1,"cliente")
  toma.ubicacion      = dw_proceso.GetItemString(x1,"ubicacion")
  toma.tipo_unidad    = dw_proceso.GetItemString(x1,"tipo_unidad")
  toma.referencia     = dw_proceso.GetItemString(x1,"referencia")
  toma.f_alta         = dw_proceso.GetItemdatetime(x1,"f_alta")
  toma.observaciones  = dw_proceso.GetItemString(x1,"observaciones")
  toma.tipo_pallet    = dw_proceso.GetItemString(x1,"tipo_pallet")
  toma.caja           = dw_proceso.GetItemString(x1,"caja")  
  toma.fecha_inv      = fecha
  toma.anyo_inv       = year(date(fecha))
  toma.usuario        = nombre_usuario

  inv.fecha_alta       = DateTime(today(),now())
  inv.fecha_inv        = fecha
  inv.empresa          = toma.empresa
  inv.almacen          = toma.almacen   
  inv.zona             = toma.zona
  inv.fila             = toma.fila
  inv.altura           = toma.altura
  inv.linea            = toma.linea   
  inv.articulo         = toma.articulo
  inv.familia          = toma.familia   
  inv.formato          = toma.formato
  inv.modelo           = toma.modelo   
  inv.calidad          = toma.calidad
  inv.tonochar         = toma.tonochar   
  inv.calibre          = toma.calibre
  inv.existencias      = toma.existencias   
  inv.anyo             = toma.anyo
  inv.pedido           = toma.pedido   
  inv.linped           = toma.linped
  inv.cliente          = toma.cliente
  inv.ubicacion        = toma.ubicacion
  inv.tipo_unidad      = toma.tipo_unidad   
  inv.referencia       = toma.referencia
  inv.f_alta           = toma.f_alta 
  inv.observaciones    = toma.observaciones
  inv.tipo_pallet      = toma.tipo_pallet
  inv.caja             = toma.caja
  inv.anyo_inv         = year(date(fecha))
  inv.usuario          = nombre_usuario
  SetNull(inv.fecha_actualizado)

  inv.pallets          = f_calculo_pallets(inv.empresa,inv.articulo,&
                         inv.tipo_pallet,inv.caja,inv.existencias)
  inv.cajas            = f_calculo_cajas(inv.empresa,inv.articulo,&
                         inv.tipo_pallet,inv.caja,inv.pallets,inv.existencias)

   INSERT INTO alminvent 
  (empresa,almacen,zona,fila,altura,linea,articulo,familia,formato,   
   modelo,calidad,tonochar,calibre,existencias,anyo,pedido,linped,cliente,   
   ubicacion,tipo_unidad,referencia,f_alta,observaciones,fecha_inv,   
   fecha_alta,tipo_pallet,caja,anyo_inv,pallets,cajas,usuario,fecha_actualizado)  
  VALUES (:inv.empresa,:inv.almacen,:inv.zona,:inv.fila,:inv.altura,   
          :inv.linea,:inv.articulo,:inv.familia,:inv.formato,
          :inv.modelo,:inv.calidad,:inv.tonochar,:inv.calibre,
          :inv.existencias,:inv.anyo,:inv.pedido,:inv.linped,
          :inv.cliente,:inv.ubicacion,:inv.tipo_unidad,:inv.referencia,   
          :inv.f_alta,:inv.observaciones,:inv.fecha_inv,
          :inv.fecha_alta,:inv.tipo_pallet,:inv.caja,:inv.anyo_inv,:inv.pallets,
          :inv.cajas,:inv.usuario,:inv.fecha_actualizado)USING SQLCA;
          IF SQLCA.SQLCode<>0 THEN  bien=1
     
  NEXT
ELSE
  bien=1
END IF




IF bien=0 THEN
  Return TRUE
ELSE
  Return FALSE
END IF

end function

public subroutine f_control_insercion ();str_alminv  var
String campo,mensaje,var_sector
Integer controles
long  posi,posi_aux

controles=0
   var.empresa     = dw_insertar.GetItemString(dw_insertar.GetRow(),"empresa")
   var.almacen     = dw_1.GetItemString(dw_1.GetRow(),"almacen")
   var.fecha_inv   = dw_1.GetItemDateTime(dw_1.GetRow(),"fecha_inv")
   var.zona        = dw_zonas.GetItemString(dw_zonas.GetRow(),"zona")
   var.fila        = dw_insertar.GetItemNumber(dw_insertar.GetRow(),"fila")
   var.altura      = dw_insertar.GetItemNumber(dw_insertar.GetRow(),"altura")
   SetNull(var.linea) // Para las nuevas  lineas       
   var.articulo    = dw_insertar.GetItemString(dw_insertar.GetRow(),"articulo")
   var.calidad     = dw_insertar.GetItemString(dw_insertar.GetRow(),"calidad")
   var.tonochar    = dw_insertar.GetItemString(dw_insertar.GetRow(),"tonochar")
   var.calibre     = dw_insertar.GetItemNumber(dw_insertar.GetRow(),"calibre")
	
	IF Not f_control_tono_artcal(codigo_empresa,var.articulo,var.calidad) Then
		var.tonochar       =  ""
	else
		if trim(var.tonochar) ="" then var.tonochar =  "0"
	END IF
	
	IF Not f_control_calibre_artcal(codigo_empresa,var.articulo,var.calidad) Then
		var.calibre  = 0
	else
		if isnull(var.calibre) then var.calibre = 0
		if var.calibre = 0 then var.calibre = 1
	END IF  	
	
   var.existencias = dw_insertar.GetItemNumber(dw_insertar.GetRow(),"existencias")
   SetNull(var.anyo)
   SetNull(var.pedido)
   SetNull(var.linped)
   SetNull(var.cliente)
   var.ubicacion  = f_componer_ubicacion(var.almacen,var.zona,var.fila,var.altura)
   var.referencia = f_componer_ref(var.articulo,var.calidad,var.tonochar,var.calibre)
   var.f_alta     = Datetime(Today(),now())
   SetNull(var.observaciones)
   var.f_alta      = Datetime(Today(),now())  
   var.tipo_pallet = dw_insertar.GetItemString(dw_insertar.GetRow(),"tipo_pallet")
   var.caja        = dw_insertar.GetItemString(dw_insertar.GetRow(),"caja")
   var.anyo_inv    = Integer(em_periodo.text)
   var.pallets     = dw_insertar.GetItemNumber(dw_insertar.GetRow(),"pallets")
   var.cajas       = dw_insertar.GetItemNumber(dw_insertar.GetRow(),"cajas")
   SetNull(var.fecha_actualizado)
   var.usuario=nombre_usuario

// Control Aceptacion de valores//
//------------------------------//

String cadena
//cadena=f_calculo_unidades(var.empresa, var.articulo,var.tipo_pallet,var.caja,&
//                          var.pallets,var.cajas,var.existencias)
//var.pallets=Integer(Mid(cadena,1,6))
//var.cajas=Integer(Mid(cadena,7,6))
//var.existencias=Dec(Mid(cadena,19,9))

cadena=f_calculo_unidades(var.empresa,var.articulo,var.tipo_pallet,var.caja,0,0,&
                          var.existencias)
posi_aux = 1
posi = pos(cadena,"|",1)

if posi <> 0 then
	var.pallets     = dec(Mid(cadena,1,posi - 1))
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <> 0 then
	var.cajas         = dec(Mid(cadena,posi_aux,posi - posi_aux))
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	var.existencias    = dec(Mid(cadena,posi_aux,posi - posi_aux))
	posi_aux = posi + 1
end if

//var.pallets=Integer(Mid(cadena,1,6))
//var.cajas=Integer(Mid(cadena,7,6))
//var.existencias=Dec(Mid(cadena,19,9))


DO WHILE  controles =0

 IF IsNull(var.fila)  Then
  controles=1
  campo  ="fila"
  mensaje = "Introduzca la fila"
  EXIT
END IF
 IF IsNull(var.altura)   Then
  controles=1
  campo  ="altura"
  mensaje = "Introduzca la altura"
  EXIT
END IF
 SELECT articulos.empresa,articulos.codigo,articulos.formato,
        articulos.modelo,articulos.familia,articulos.unidad,articulos.sector
 INTO :var.empresa,:var.articulo,:var.formato,:var.modelo,
      :var.familia,:var.tipo_unidad,:var_sector
    FROM  articulos  
   WHERE (articulos.empresa = :var.empresa ) AND  
         (articulos.codigo = :var.articulo )   ;

IF Sqlca.SqlCode <>0 Then
  controles=1
  campo  ="articulo"
  mensaje = "No existe el articulo"
  EXIT
END IF
IF var_sector = "S" Then
				  SELECT calidades.empresa,calidades.codigo  
					 INTO :var.empresa,:var.calidad  
					 FROM calidades  
					WHERE ( calidades.empresa = :var.empresa ) AND  
							( calidades.codigo = :var.calidad ) 
				ORDER BY calidades.empresa ASC,calidades.codigo ASC  ;
				IF Sqlca.SqlCode <>0 Then
				  controles=1
				  campo  ="calidad"
				  mensaje = "No existe la calidad"
				  EXIT
				END IF  
				
				
				
				
				SELECT almartcal.empresa,almartcal.articulo,almartcal.calidad  
				INTO :var.empresa,:var.articulo,:var.calidad  
				FROM almartcal  
				WHERE (almartcal.empresa  =:var.empresa)
				AND   (almartcal.articulo =:var.articulo)
				AND   (almartcal.calidad  =:var.calidad)   
				ORDER BY almartcal.empresa ASC,almartcal.articulo ASC,
							almartcal.calidad ASC;
				IF Sqlca.SqlCode <>0 Then
				  controles=1
				  campo  ="calidad"
				  mensaje = "No existe esta calidad a este articulo"
				  EXIT
				END IF
				
				  SELECT pallets.empresa,pallets.codigo  
					 INTO :var.empresa,:var.tipo_pallet  
					 FROM pallets  
					WHERE ( pallets.empresa = :var.empresa ) AND  
							( pallets.codigo  = :var.tipo_pallet )   
				ORDER BY pallets.empresa ASC,pallets.codigo ASC  ;
				IF Sqlca.SqlCode <>0 Then
				  controles=1
				  campo  ="tipo_pallet"
				  mensaje = "No existe el Tipo de Pallet"
				  EXIT
				END IF
				 
				  SELECT palarticulo.empresa,palarticulo.articulo,palarticulo.codigo  
					 INTO :var.empresa,:var.articulo,:var.tipo_pallet  
					 FROM palarticulo
					WHERE ( palarticulo.empresa = :var.empresa ) AND  
							( palarticulo.articulo = :var.articulo ) AND  
							( palarticulo.codigo = :var.tipo_pallet ) AND
							( palarticulo.caja   = :var.caja)
				ORDER BY palarticulo.empresa ASC,palarticulo.articulo ASC,
							palarticulo.codigo ASC  ;
				IF Sqlca.SqlCode <>0 Then
				  controles=1
				  campo  ="tipo_pallet"
				  mensaje = "No existe el tipo de pallet para el artículo"
				  EXIT
				END IF
END IF
 IF Not f_ubi_exist(var.empresa,var.almacen,var.zona,var.fila,var.altura) Then
  controles = 1
  campo   = "zona"
  mensaje = "No existe la ubicacion en el mapa"
  EXIT
 END IF
IF var.existencias=0 or IsNull(var.existencias) Then
  controles = 1
  campo   = "existencias"
  mensaje = "Introduzca las existencias"
  EXIT
END IF
EXIT
LOOP


IF controles=1 THEN
  MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
  dw_insertar.SetColumn(campo)
  dw_insertar.setRow(dw_insertar.GetRow())
  dw_insertar.setfocus()
  Return 
END IF

Integer x1,opcion
opcion=3
FOR x1= 1 to dw_inv.RowCount()
  IF var.ubicacion   = dw_inv.GetItemString(x1,"ubicacion") and &
     var.referencia  = dw_inv.GetItemString(x1,"referencia") and &
     var.tipo_pallet = dw_inv.GetItemString(x1,"tipo_pallet") and &
	  var.caja        = dw_inv.GetItemString(x1,"caja") Then

     opcion=MessageBox("Existen lineas al la misma referencia, ubicacion y tipo de pallet",&
                       "¿Desea Incrementar Existencias?",question!, YesNo!,2)
     IF opcion=2 THEN  Return
     IF opcion=1  Then
       dw_inv.SetItem(x1,"pallets",&
                      dw_inv.GetItemNumber(x1,"pallets")+var.pallets)
       dw_inv.SetItem(x1,"cajas",&
                      dw_inv.GetItemNumber(x1,"cajas")+var.cajas)
       dw_inv.SetItem(x1,"existencias",&
                      dw_inv.GetItemNumber(x1,"existencias")+var.existencias)
       dw_inv.ScrollToRow(x1)
     End If
    End If
NEXT

IF opcion=3 Then
 dw_inv.enabled=TRUE
 x1=dw_inv.RowCount()
 x1=x1+1
 dw_inv.InsertRow(x1)
 dw_inv.SetItem(x1,"empresa",var.empresa)
 dw_inv.SetItem(x1,"almacen",var.almacen)
 dw_inv.SetItem(x1,"zona",var.zona)
 dw_inv.SetItem(x1,"fila",var.fila)
 dw_inv.SetItem(x1,"altura",var.altura)
 
 dw_inv.SetItem(x1,"zonat",var.zona)
 dw_inv.SetItem(x1,"filat",var.fila)
 dw_inv.SetItem(x1,"alturat",var.altura)
 
 var.linea=x1
 Integer xlinea
 SELECT max(alminvent.linea) INTO :xlinea FROM alminvent  
 WHERE (alminvent.empresa = :var.empresa ) AND  
       (alminvent.fecha_inv = :var.fecha_inv ) AND  
       (alminvent.almacen = :var.almacen )   ;

If IsNull(xlinea) Then xlinea=0
If var.linea<= xlinea Then   var.linea=xlinea + 1

 dw_inv.SetItem(x1,"linea",var.linea)
 dw_inv.SetItem(x1,"articulo",var.articulo)
 dw_inv.SetItem(x1,"familia",var.familia)
 dw_inv.SetItem(x1,"formato",var.formato)
 dw_inv.SetItem(x1,"modelo",var.modelo)
 dw_inv.SetItem(x1,"calidad",var.calidad)
 IF ISNUll(var.tonochar) Then var.tonochar = ""
 IF ISNUll(var.calibre) Then var.calibre = 0
 dw_inv.SetItem(x1,"tonochar",var.tonochar)
 dw_inv.SetItem(x1,"tonotchar",var.tonochar)
 dw_inv.SetItem(x1,"calibre",var.calibre)
 dw_inv.SetItem(x1,"calibret",var.calibre)
 dw_inv.SetItem(x1,"existencias",var.existencias)
 dw_inv.SetItem(x1,"existenciast",0)
 dw_inv.SetItem(x1,"anyo",var.anyo)
 dw_inv.SetItem(x1,"pedido",var.pedido)
 dw_inv.SetItem(x1,"linped",var.linped)
 dw_inv.SetItem(x1,"cliente",var.cliente)
 dw_inv.SetItem(x1,"ubicacion",var.ubicacion)
 dw_inv.SetItem(x1,"tipo_unidad",var.tipo_unidad)
 dw_inv.SetItem(x1,"referencia",var.referencia)
 dw_inv.SetItem(x1,"referenciat",var.referencia)
 dw_inv.SetItem(x1,"f_alta",var.f_alta)
 dw_inv.SetItem(x1,"observaciones",var.observaciones)
 dw_inv.SetItem(x1,"fecha_inv",var.fecha_inv)
 dw_inv.SetItem(x1,"fecha_alta",var.fecha_alta)
 dw_inv.SetItem(x1,"tipo_pallet",var.tipo_pallet)
 dw_inv.SetItem(x1,"caja",var.caja)
 dw_inv.SetItem(x1,"tipo_pallett",var.tipo_pallet)
 dw_inv.SetItem(x1,"anyo_inv",var.anyo_inv)
 dw_inv.SetItem(x1,"cajas",var.cajas)
 dw_inv.SetItem(x1,"cajast",0)
 dw_inv.SetItem(x1,"pallets",var.pallets)
 dw_inv.SetItem(x1,"palletst",0)
 dw_inv.SetItem(x1,"activo","S")
 dw_inv.SetItem(x1,"fecha_actualizado",var.fecha_actualizado)
 dw_inv.SetItem(x1,"usuario",var.usuario)
 dw_inv.ScrollToRow(x1)
 dw_inv.enabled=FALSE
END IF

  dw_insertar.DeleteRow(1)
  dw_inv.enabled=FALSE
  dw_insertar.visible=TRUE
  modo_insercion="S"
  dw_insertar.InsertRow(1)
  dw_insertar.SetItem(1,"empresa",var.empresa)
  dw_insertar.SetItem(1,"almacen",var.almacen)
  dw_insertar.SetRow(1)
  dw_insertar.SetColumn("fila")
  dw_insertar.SetFocus()
  
  //-------------------------------------------------
  // Actualizo las lineas de inventario
  //-------------------------------------------------
  
Integer op
op=dw_inv.Update()
IF op = -1 THEN
  ROLLBACK using sqlca;
  MessageBox("Error en Grabacion de datos","No se graban los datos",Exclamation!, OK!,1)
ELSE
  COMMIT using sqlca;
END IF
//-------------------------------------------------------------------
RETURN 


end subroutine

public subroutine f_calculo ();Dec   ante_cajas,ante_pallets
Dec{4} var_pallets,var_cajas,var_cantidad
String val = "N"
long  posi,posi_aux

ante_cajas = dw_inv.GetItemNumber(dw_inv.GetRow(),"cajas")
ante_pallets = dw_inv.GetItemNumber(dw_inv.GetRow(),"pallets")
dw_inv.AcceptText()

string cadena
IF ante_pallets <> dw_inv.GetItemNumber(dw_inv.GetRow(),"pallets") Then
IF dw_inv.GetColumnName() ="pallets" Then
				cadena=f_calculo_unidades(codigo_empresa,&
												  dw_inv.GetItemString(dw_inv.GetRow(),"articulo"),&
												  dw_inv.GetItemString(dw_inv.GetRow(),"tipo_pallet"),&
												  dw_inv.GetItemString(dw_inv.GetRow(),"caja"),&
												  dw_inv.GetItemNumber(dw_inv.GetRow(),"pallets"),&
												  dw_inv.GetItemNumber(dw_inv.GetRow(),"cajas"),&
												  0)
													val = "S"												  
END IF
END IF

IF ante_cajas <> dw_inv.GetItemNumber(dw_inv.GetRow(),"cajas") Then
IF dw_inv.GetColumnName() ="cajas" Then
		cadena=f_calculo_unidades(codigo_empresa,&
										  dw_inv.GetItemString(dw_inv.GetRow(),"articulo"),&
										  dw_inv.GetItemString(dw_inv.GetRow(),"tipo_pallet"),&
										  dw_inv.GetItemString(dw_inv.GetRow(),"caja"),&
										  dw_inv.GetItemNumber(dw_inv.GetRow(),"pallets"),&
										  dw_inv.GetItemNumber(dw_inv.GetRow(),"cajas"),&
										  0)
											val = "S"										  
END IF
END IF


IF dw_inv.GetColumnName() ="existencias" Then
		cadena=f_calculo_unidades(codigo_empresa,&
										  dw_inv.GetItemString(dw_inv.GetRow(),"articulo"),&
										  dw_inv.GetItemString(dw_inv.GetRow(),"tipo_pallet"),&
										  dw_inv.GetItemString(dw_inv.GetRow(),"caja"),&
										  0,&
										  0,&
										  dw_inv.GetItemNumber(dw_inv.GetRow(),"existencias"))

											val = "S"
END IF

posi_aux = 1
posi = pos(cadena,"|",1)

if posi <> 0 then
	var_pallets     = dec(Mid(cadena,1,posi - 1))
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <> 0 then
	var_cajas         = dec(Mid(cadena,posi_aux,posi - posi_aux))
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	var_cantidad      = dec(Mid(cadena,posi_aux,posi - posi_aux))
	posi_aux = posi + 1
end if

IF val = "S" Then
	dw_inv.SetItem(dw_inv.GetRow(),"pallets",var_pallets)
	dw_inv.SetItem(dw_inv.GetRow(),"cajas",var_cajas)
	dw_inv.SetItem(dw_inv.GetRow(),"existencias",var_cantidad)
END IF
                           
                      


end subroutine

on close;call w_int_con_empresa::close;IF bloqueado="S" THEN 
 f_desbloquear(tabla,seleccion,titulo)
 COMMIT using sqlca;
END IF
end on

event open;call super::open;bloqueado="N"
istr_parametros.s_titulo_ventana="Introduccion inventarios"
This.title=istr_parametros.s_titulo_ventana
dw_1.settransobject(SQLCA)
dw_zonas.settransobject(SQLCA)
dw_inv.settransobject(SQLCA)
dw_proceso.settransobject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)		// Use hand for focus indicator
em_periodo.text=String(year(today()))
dw_1.Retrieve(codigo_empresa,Integer(em_periodo.text))
//dw_inv.SetRowFocusIndicator(Hand!)	
dw_zonas.SetRowFocusIndicator(Hand!)	
grabado="N"
dw_inv.visible= FALSE


end event

on w_int_alminvent.create
int iCurrent
call super::create
this.st_2=create st_2
this.em_periodo=create em_periodo
this.dw_1=create dw_1
this.dw_proceso=create dw_proceso
this.cb_salir=create cb_salir
this.cb_grabar=create cb_grabar
this.dw_zonas=create dw_zonas
this.pb_1=create pb_1
this.cb_insertar=create cb_insertar
this.cb_1=create cb_1
this.dw_insertar=create dw_insertar
this.dw_inv=create dw_inv
this.st_6=create st_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.em_periodo
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_proceso
this.Control[iCurrent+5]=this.cb_salir
this.Control[iCurrent+6]=this.cb_grabar
this.Control[iCurrent+7]=this.dw_zonas
this.Control[iCurrent+8]=this.pb_1
this.Control[iCurrent+9]=this.cb_insertar
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.dw_insertar
this.Control[iCurrent+12]=this.dw_inv
this.Control[iCurrent+13]=this.st_6
end on

on w_int_alminvent.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.em_periodo)
destroy(this.dw_1)
destroy(this.dw_proceso)
destroy(this.cb_salir)
destroy(this.cb_grabar)
destroy(this.dw_zonas)
destroy(this.pb_1)
destroy(this.cb_insertar)
destroy(this.cb_1)
destroy(this.dw_insertar)
destroy(this.dw_inv)
destroy(this.st_6)
end on

event activate;call super::activate;w_int_alminvent = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_alminvent
integer taborder = 30
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_alminvent
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_alminvent
integer y = 12
integer width = 2661
end type

type st_2 from statictext within w_int_alminvent
integer x = 14
integer y = 180
integer width = 274
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Periodo"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_periodo from u_em_campo within w_int_alminvent
integer x = 306
integer y = 172
integer taborder = 40
maskdatatype maskdatatype = numericmask!
string mask = "####"
end type

on modified;call u_em_campo::modified;dw_1.Retrieve(codigo_empresa,Integer(em_periodo.text))
end on

type dw_1 from datawindow within w_int_alminvent
integer x = 585
integer y = 160
integer width = 1582
integer height = 984
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_int_alminvent1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

on losefocus;This.BorderStyle=StyleRaised!
end on

on getfocus;This.BorderStyle=StyleLowered!
end on

event rowfocuschanged;
if dw_1.rowcount() > 0 then
	dw_zonas.Retrieve(codigo_empresa,&
							dw_1.GetItemDatetime(dw_1.GetRow(),"fecha_inv"),&
							dw_1.GetItemString(dw_1.GetRow(),"almacen"))
end if
end event

type dw_proceso from datawindow within w_int_alminvent
boolean visible = false
integer x = 9
integer width = 494
integer height = 176
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_proceso_inventario"
boolean livescroll = true
end type

type cb_salir from u_boton within w_int_alminvent
boolean visible = false
integer x = 837
integer y = 1352
integer height = 76
integer taborder = 0
string text = "&Salir"
end type

event clicked;call super::clicked;IF modo_insercion="N" THEN
 IF grabado="N" Then
   Integer opcion
   opcion=MessageBox("Al salir sin grabar no se actualizan los cambios",&
                       "¿Desea Salir?",question!, YesNo!,2)
    If opcion=2 Then 
       dw_inv.SetFocus()
       Return
    End If
 END IF

 dw_1.enabled        = TRUE
 dw_zonas.enabled    =TRUE
 em_periodo.enabled  = TRUE
 cb_1.enabled        = TRUE
 dw_inv.enabled     = FALSE
 dw_inv.reset()
 cb_grabar.visible   = FALSE
 cb_salir.visible    = FALSE
 cb_insertar.visible    = FALSE
 dw_inv.visible= FALSE
 f_desbloquear(tabla,seleccion,titulo)
 COMMIT using sqlca;
 bloqueado="N"
 f_activar_campo(em_periodo)
 Return
ELSE
 dw_insertar.visible=FALSE
 cb_insertar.enabled=TRUE
 modo_insercion="N"
 dw_inv.enabled=TRUE
 dw_insertar.DeleteRow(1)
 dw_inv.SetFocus()
 Return
END IF
end event

type cb_grabar from u_boton within w_int_alminvent
boolean visible = false
integer x = 23
integer y = 1352
integer height = 76
integer taborder = 0
string text = "&Grabar"
end type

event clicked;Int r
//dw_inv.AcceptText()
dw_insertar.AcceptText()
f_calculo()

For r = 1 To dw_inv.RowCount()
	dw_inv.SetItem(r,"referencia",f_componer_ref(dw_inv.GetItemSTring(r,"articulo"),dw_inv.GetItemSTring(r,"calidad"),dw_inv.GetItemString(r,"tonochar"),dw_inv.GetItemNumber(r,"calibre")))
Next


IF modo_insercion="N" THEN
Integer opcion
opcion=MessageBox("Al grabar de actualizan los cambios",&
                       "¿Desea Grabar?",question!, YesNo!,2)
If opcion=2 Then 
   dw_inv.SetFocus()
   Return
End If

             

Integer op
op=dw_inv.Update()
IF op = -1 THEN
  ROLLBACK using sqlca;
  MessageBox("Error en Grabacion de datos","No se graban los datos",Exclamation!, OK!,1)
ELSE
  COMMIT using sqlca;
END IF
grabado="S"
cb_salir.TriggerEvent(Clicked!)
ELSE
 f_control_insercion() 
 Return
END IF
end event

type dw_zonas from datawindow within w_int_alminvent
integer x = 2167
integer y = 160
integer width = 457
integer height = 984
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_int_alminvent3"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

on losefocus;This.BorderStyle=StyleRaised!
end on

on getfocus;This.BorderStyle=StyleLowered!
end on

type pb_1 from upb_salir within w_int_alminvent
integer x = 3022
integer y = 8
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "exit!"
end type

type cb_insertar from u_boton within w_int_alminvent
boolean visible = false
integer x = 430
integer y = 1352
integer height = 76
integer taborder = 0
string text = "&Insertar"
end type

event clicked;call super::clicked;Integer registro
IF modo_insercion="N" Then
  dw_inv.enabled=FALSE
  dw_insertar.visible=TRUE
  modo_insercion="S"
  
  dw_insertar.InsertRow(1)
  dw_insertar.SetItem(1,"empresa",codigo_empresa)
  dw_insertar.SetItem(1,"almacen",dw_1.GetItemString(dw_1.GetRow(),"almacen"))
  dw_insertar.SetRow(1)
  dw_insertar.SetColumn("fila")
  dw_insertar.SetFocus()
  This.enabled = FALSE
END IF
end event

type cb_1 from u_boton within w_int_alminvent
integer x = 320
integer y = 344
integer width = 224
integer height = 148
integer taborder = 50
string text = "&OK"
end type

event clicked;call super::clicked;IF dw_1.GetRow() = 0 Then  Return
If dw_zonas.GetRow() = 0 Then Return


 titulo        =  Parent.title
 longitud      =  len(trim(codigo_empresa))
 criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
 longitud      =  len(trim(string(dw_1.GetItemDateTime(dw_1.GetRow(),"fecha_inv"))))
 criterio[2]   =  trim(string(dw_1.GetItemDateTime(dw_1.GetRow(),"fecha_inv")))+space(20-longitud)
 longitud      =  len(trim(dw_1.GetItemString(dw_1.GetRow(),"almacen")))
 criterio[3]   =  trim(dw_1.GetItemString(dw_1.GetRow(),"almacen"))+space(20-longitud)
 longitud      =  len(trim(dw_zonas.GetItemString(dw_zonas.GetRow(),"zona")))
 criterio[4]   =  trim(dw_zonas.GetItemString(dw_zonas.GetRow(),"zona"))+space(20-longitud)
 seleccion     =  criterio[1]+criterio[2]+criterio[3]+criterio[4]
 tabla         =  "alminvent"
 IF NOT f_bloquear(tabla,seleccion,titulo) THEN
  COMMIT Using SQLCA; //Solucion nivel insolacion
  bloqueado="S"

modo_insercion="N"
Integer registros
Boolean valor
registros  =  dw_inv.Retrieve(codigo_empresa,&
                          dw_1.GetItemDatetime(dw_1.Getrow(),"fecha_inv"),&
                          dw_1.GetItemString(dw_1.Getrow(),"almacen"),&
                          dw_zonas.GetItemString(dw_zonas.Getrow(),"zona"))

IF registros=0 THEN
IF NOT f_preinput(codigo_empresa,dw_1.GetItemDateTime(dw_1.Getrow(),"fecha_inv"),&
                 dw_1.GetItemString(dw_1.Getrow(),"almacen"),&
                 dw_zonas.GetItemString(dw_zonas.Getrow(),"zona")) THEN
   ROLLBACK using sqlca;
ELSE
   COMMIT using sqlca;
END IF
dw_inv.Retrieve(codigo_empresa,dw_1.GetItemDateTime(dw_1.Getrow(),"fecha_inv"),&
                dw_1.GetItemString(dw_1.Getrow(),"almacen"),&
                dw_zonas.GetItemString(dw_zonas.Getrow(),"zona"))
ELSE

END IF
dw_1.enabled        = FALSE
dw_zonas.enabled    =FALSE
em_periodo.enabled  = FALSE
cb_1.enabled        = FALSE
dw_inv.enabled      = TRUE
cb_grabar.visible   = TRUE
cb_salir.visible    = TRUE
cb_insertar.visible = TRUE
dw_inv.visible = TRUE

dw_inv.SetFocus()
dw_inv.SetRow(1)
dw_inv.SelectRow(1,True)
END IF


end event

type dw_insertar from datawindow within w_int_alminvent
event key pbm_dwnkey
boolean visible = false
integer x = 14
integer y = 1048
integer width = 2816
integer height = 304
boolean titlebar = true
string title = "Introducción de lineas manuales"
string dataobject = "dw_int_alminvent4"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event key;long posi,posi_aux
dec  var_pallets,var_cajas,var_cantidad

IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
  
  str_parametros param
  String bus_campo,bus_cadena
  SetNull(bus_campo)
  string cadena
  param.b_empresa = TRUE
  This.AcceptText()
  param.s_criterio_busqueda=""
  bus_campo = This.GetColumnName()
  if dec(This.GetItemString(This.GetRow(),"articulo")) > 0 then
	  cadena = f_calculo_unidades(codigo_empresa,&
                           This.GetItemString(This.GetRow(),"articulo"),&
                           This.GetItemString(This.GetRow(),"tipo_pallet"),&
                           This.GetItemString(This.GetRow(),"caja"),&									
                           This.GetItemNumber(This.GetRow(),"pallets"),&
                           This.GetItemNumber(This.GetRow(),"cajas"),&
                           This.GetItemNumber(This.GetRow(),"existencias"))
  end if
  CHOOSE CASE bus_campo
  CASE "existencias"
      cadena=f_calculo_unidades(codigo_empresa,&
                          This.GetItemString(This.GetRow(),"articulo"),&
                          This.GetItemString(This.GetRow(),"tipo_pallet"),&
                          This.GetItemString(This.GetRow(),"caja"),&								  
                          0,&
                          0,&
                          This.GetItemNumber(This.GetRow(),"existencias"))
   SetNull(bus_campo)
	CASE "almacen"
      param.s_titulo_ayuda     = "VENTANA SELECCION DE TIPO DE ALMACEN "
 		param.s_nom_datawindow   =  "dw_ayuda_almacenes"
      param.s_filtro            = ""
   CASE "zona"
      param.s_titulo_ayuda     = "VENTANA SELECCION DE TIPO DE ZONA "
 		param.s_nom_datawindow   =  "dw_ayuda_almubizonas"
      param.s_filtro            = "almacen='" +  &
                                   This.GetItemString(This.GetRow(),"almacen") + "'"
   CASE "articulo"
      param.s_titulo_ayuda     = "VENTANA SELECCION DE ARTICULOS "
 		param.s_nom_datawindow   =  "dw_ayuda_articulos"
     param.s_filtro            = ""

   CASE "calidad"
      param.s_titulo_ayuda     = "VENTANA SELECCION DE CALIDADES "
 		param.s_nom_datawindow   =  "dw_ayuda_calidades"
      param.s_filtro            = ""
   CASE "tipo_pallet"
      param.s_titulo_ayuda     = "VENTANA SELECCION DE PALLETS "
 		param.s_nom_datawindow   =  "dw_ayuda_palarticulo_abr"
      param.s_filtro           = "(palarticulo_articulo = '" +This.GetItemString(This.GetRow(),"articulo")+ "') and "+&
                                  "(palarticulo_caja = '" +This.GetItemString(This.GetRow(),"caja")+ "')" 		
   CASE "caja"
      param.s_titulo_ayuda     = "VENTANA SELECCION DE CAJAS "
 		param.s_nom_datawindow   =  "dw_ayuda_almartcajas"
      param.s_filtro           = "almartcajas_articulo = '" +This.GetItemString(This.GetRow(),"articulo")+ "'"		
   CASE ELSE
     SetNull(bus_campo)

 END CHOOSE
 posi_aux = 1
posi = pos(cadena,"|",1)
if posi <> 0 then
	var_pallets     = dec(Mid(cadena,1,posi))
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <> 0 then
	var_cajas       = dec(Mid(cadena,posi_aux,posi - posi_aux))
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	var_cantidad      = dec(Mid(cadena,posi_aux,posi - posi_aux))
	posi_aux = posi + 1
end if

This.SetItem(This.GetRow(),"pallets",var_pallets)
This.SetItem(This.GetRow(),"cajas",var_cajas)
This.SetItem(This.GetRow(),"existencias",var_cantidad)

// Ventanas de ayuda campos relacion de las datawindows
  String bus_cadena_return
  IF Trim(bus_campo)="" or IsNull(bus_campo) THEN  Return
  This.accepttext()
  bus_cadena = This.GetItemString(This.GetRow(),This.GetColumnName())
  IF IsNull(bus_cadena) or ISNumber(bus_cadena) THEN bus_cadena = ""
IF KeyDown(KeyEnter!) OR (KeyDown(KeyTab!) and Trim(bus_cadena)<>"") THEN
  param.s_criterio_busqueda  = bus_cadena
  OpenWithParm(w_busquedas,param)

  bus_cadena_return = Message.StringParm		// Devuelve el valor que enuentra ...
  IF Trim(bus_cadena_return)= "" or IsNull(bus_cadena_return) THEN
     bus_cadena= This.GetItemString(This.GetRow(),This.GetColumnName())
  ELSE
     bus_cadena=bus_cadena_return
  END IF
  This.SetItem(This.getrow(),This.GetColumn(),bus_cadena)
  SetColumn(This.GetColumn())
  This.SetRow(This.getrow())
  This.Setfocus()
END IF
END IF


end event

type dw_inv from datawindow within w_int_alminvent
event key pbm_dwnkey
boolean visible = false
integer x = 27
integer y = 124
integer width = 3127
integer height = 1224
boolean enabled = false
string dataobject = "dw_int_alminvent2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event key;IF  KeyDown(KeyTab!) Then f_calculo()
IF  KeyDown(KeyDownArrow!) Then f_calculo()
IF  KeyDown(KeyUpArrow!) Then f_calculo()



String cadena

// AYUDAS------------------//
//-------------------------//
IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
  
  str_parametros param
  String bus_campo,bus_cadena
  SetNull(bus_campo)
  param.b_empresa = TRUE
  This.AcceptText()
  param.s_criterio_busqueda=""
  bus_campo = This.GetColumnName()
  CHOOSE CASE bus_campo
   CASE "tipo_pallet"
      param.s_titulo_ayuda     = "VENTANA SELECCION DE PALLETS "
 		param.s_nom_datawindow   =  "dw_ayuda_palarticulo_abr"
      param.s_filtro           = "(palarticulo_articulo = '" +GetItemString(GetRow(),"articulo")+ "') and "+&
                                  "(palarticulo_caja = '" +GetItemString(GetRow(),"caja")+ "')" 		
   CASE "caja"
      param.s_titulo_ayuda     = "VENTANA SELECCION DE CAJAS "
 		param.s_nom_datawindow   =  "dw_ayuda_almartcajas"
      param.s_filtro           = "almartcajas_articulo = '" +GetItemString(GetRow(),"articulo")+ "'"				
   CASE ELSE
     SetNull(bus_campo)

 END CHOOSE
// Ventanas de ayuda campos relacion de las datawindows
  String bus_cadena_return
  IF Trim(bus_campo)="" or IsNull(bus_campo) THEN  Return
  This.accepttext()
  bus_cadena = This.GetItemString(This.GetRow(),This.GetColumnName())
  IF IsNull(bus_cadena) or ISNumber(bus_cadena) THEN bus_cadena = ""
IF KeyDown(KeyEnter!) OR (KeyDown(KeyTab!) and Trim(bus_cadena)<>"") THEN
  param.s_criterio_busqueda  = bus_cadena
  OpenWithParm(w_busquedas,param)

  bus_cadena_return = Message.StringParm		// Devuelve el valor que enuentra ...
  IF Trim(bus_cadena_return)= "" or IsNull(bus_cadena_return) THEN
     bus_cadena= This.GetItemString(This.GetRow(),This.GetColumnName())
  ELSE
     bus_cadena=bus_cadena_return
  END IF
  This.SetItem(This.getrow(),This.GetColumn(),bus_cadena)
  SetColumn(This.GetColumn())
  This.SetRow(This.getrow())
  This.Setfocus()
  
f_calculo()
END IF
END IF


end event

event clicked;f_calculo()
IF f_objeto_datawindow(This) = "fila" Then
	SetTabOrder("fila",1)
	SetColumn("fila")
END IF
IF f_objeto_datawindow(This) = "altura" Then
	SetTabOrder("altura",1)
	SetColumn("altura")
END IF
IF f_objeto_datawindow(This) = "tipo_pallet" Then
	SetTabOrder("tipo_pallet",1)
	SetColumn("tipo_pallet")
END IF
IF f_objeto_datawindow(This) = "caja" Then
	SetTabOrder("caja",1)
	SetColumn("caja")
END IF
end event

event rowfocuschanged;this.selectRow(0,False)
this.selectRow(currentrow,True)
SetTabOrder("fila",0)
SetTabOrder("altura",0)
SetTabOrder("tipo_pallet",0)
SetTabOrder("caja",0)
end event

type st_6 from statictext within w_int_alminvent
integer x = 5
integer y = 140
integer width = 3200
integer height = 1292
boolean bringtotop = true
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
string text = "NO USAR - OBSOLETO "
alignment alignment = center!
boolean focusrectangle = false
end type

